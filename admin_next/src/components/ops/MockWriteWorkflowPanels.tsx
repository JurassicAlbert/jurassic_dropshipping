"use client";

import { useEffect, useMemo, useState } from "react";
import {
  Alert,
  Box,
  Button,
  Card,
  CardContent,
  Chip,
  Dialog,
  DialogActions,
  DialogContent,
  DialogTitle,
  FormControl,
  InputLabel,
  MenuItem,
  Select,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
  Typography,
} from "@mui/material";
import type {
  ApprovalListing,
  ApprovalOrder,
  IncidentRow,
  ReturnRow,
  RiskDashboardSnapshot,
  SupplierReturnPolicy,
  SupplierRow,
} from "@/lib/adminTransport";
import { getAdminTransport } from "@/lib/adminTransport";

function reqId(prefix: string): string {
  return `${prefix}-${Date.now()}-${Math.random().toString(36).slice(2, 8)}`;
}

type ApiError = { message: string };

function toMessage(error: ApiError | null): string | null {
  return error?.message ?? null;
}

export function ApprovalWorkflowPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [pendingListings, setPendingListings] = useState<ApprovalListing[]>([]);
  const [pendingOrders, setPendingOrders] = useState<ApprovalOrder[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    const [lRes, oRes] = await Promise.all([
      transport.approvalGetPendingListings(reqId("approval-listings")),
      transport.approvalGetPendingOrders(reqId("approval-orders")),
    ]);
    if (lRes.ok) setPendingListings(lRes.pendingListings);
    else setError({ message: lRes.error.message });
    if (oRes.ok) setPendingOrders(oRes.pendingOrders);
    else setError((prev) => prev ?? { message: oRes.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const runAction = async (kind: "approveListing" | "rejectListing" | "approveOrder" | "rejectOrder", id: string) => {
    setLoading(true);
    setError(null);
    let ok = true;
    let message = "";
    if (kind === "approveListing") {
      const res = await transport.approvalApproveListing(id, reqId("approval-approve-listing"));
      ok = res.ok;
      if (!res.ok) message = res.error.message;
    } else if (kind === "rejectListing") {
      const res = await transport.approvalRejectListing(id, reqId("approval-reject-listing"));
      ok = res.ok;
      if (!res.ok) message = res.error.message;
    } else if (kind === "approveOrder") {
      const res = await transport.approvalApproveAndFulfillOrder(id, reqId("approval-approve-order"));
      ok = res.ok;
      if (!res.ok) message = res.error.message;
    } else {
      const res = await transport.approvalRejectOrder(id, reqId("approval-reject-order"), "mock reject");
      ok = res.ok;
      if (!res.ok) message = res.error.message;
    }
    if (!ok) setError({ message });
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Approval Write Workflows</Typography>
            <Chip label={`Pending listings: ${pendingListings.length}`} size="small" />
            <Chip label={`Pending orders: ${pendingOrders.length}`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}

          <Typography variant="subtitle2">Listings</Typography>
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell align="right">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {pendingListings.slice(0, 10).map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>{r.id}</TableCell>
                    <TableCell>{r.status}</TableCell>
                    <TableCell align="right">
                      <Button size="small" onClick={() => runAction("approveListing", r.id)} disabled={loading}>
                        Approve
                      </Button>
                      <Button size="small" color="error" onClick={() => runAction("rejectListing", r.id)} disabled={loading}>
                        Reject
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>

          <Typography variant="subtitle2">Orders</Typography>
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell align="right">Actions</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {pendingOrders.slice(0, 10).map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>{r.targetOrderId}</TableCell>
                    <TableCell>{r.status}</TableCell>
                    <TableCell align="right">
                      <Button size="small" onClick={() => runAction("approveOrder", r.id)} disabled={loading}>
                        Approve & Fulfill
                      </Button>
                      <Button size="small" color="error" onClick={() => runAction("rejectOrder", r.id)} disabled={loading}>
                        Reject
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Stack>
      </CardContent>
    </Card>
  );
}

export function ReturnsWorkflowPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [rows, setRows] = useState<ReturnRow[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);
  const [selected, setSelected] = useState<ReturnRow | null>(null);
  const [status, setStatus] = useState<ReturnRow["status"]>("requested");
  const [notes, setNotes] = useState("");
  const [refundAmount, setRefundAmount] = useState("");
  const [addToReturnedStock, setAddToReturnedStock] = useState(false);

  const load = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.returnsGetReturns(reqId("returns-list"));
    if (res.ok) setRows(res.rows);
    else setError({ message: res.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const openEdit = (r: ReturnRow) => {
    setSelected(r);
    setStatus(r.status);
    setNotes(r.notes ?? "");
    setRefundAmount(r.refundAmount != null ? String(r.refundAmount) : "");
    setAddToReturnedStock(false);
  };

  const computeRouting = async () => {
    if (!selected) return;
    const res = await transport.returnsComputeRouting(reqId("returns-routing"), selected.id);
    if (!res.ok) setError({ message: res.error.message });
  };

  const save = async () => {
    if (!selected) return;
    setLoading(true);
    setError(null);
    const res = await transport.returnsUpdateReturn(
      reqId("returns-save"),
      selected.id,
      {
        status,
        notes: notes.trim() || null,
        refundAmount: refundAmount.trim() ? Number(refundAmount) : null,
      },
      addToReturnedStock,
    );
    if (!res.ok) setError({ message: res.error.message });
    setSelected(null);
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Returns Write Workflows</Typography>
            <Chip label={`Rows: ${rows.length}`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Order</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell align="right">Action</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.slice(0, 10).map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>{r.id}</TableCell>
                    <TableCell>{r.orderId}</TableCell>
                    <TableCell>{r.status}</TableCell>
                    <TableCell align="right">
                      <Button size="small" onClick={() => openEdit(r)}>
                        Edit
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Stack>
      </CardContent>

      <Dialog open={!!selected} onClose={() => setSelected(null)} fullWidth maxWidth="sm">
        <DialogTitle>Edit Return</DialogTitle>
        <DialogContent>
          <Stack spacing={1.5} sx={{ mt: 0.5 }}>
            <FormControl size="small">
              <InputLabel>Status</InputLabel>
              <Select value={status} label="Status" onChange={(e) => setStatus(e.target.value as ReturnRow["status"])}>
                {["requested", "approved", "shipped", "received", "refunded", "rejected"].map((s) => (
                  <MenuItem key={s} value={s}>
                    {s}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
            <TextField size="small" label="Refund amount" value={refundAmount} onChange={(e) => setRefundAmount(e.target.value)} />
            <TextField size="small" label="Notes" value={notes} onChange={(e) => setNotes(e.target.value)} />
            <Button size="small" variant="outlined" onClick={computeRouting}>
              Compute routing
            </Button>
            <Box>
              <Button
                size="small"
                variant={addToReturnedStock ? "contained" : "outlined"}
                onClick={() => setAddToReturnedStock((v) => !v)}
              >
                Add to returned stock on save
              </Button>
            </Box>
          </Stack>
        </DialogContent>
        <DialogActions>
          <Button onClick={() => setSelected(null)}>Cancel</Button>
          <Button variant="contained" onClick={save} disabled={loading}>
            Save
          </Button>
        </DialogActions>
      </Dialog>
    </Card>
  );
}

export function IncidentsWorkflowPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [rows, setRows] = useState<IncidentRow[]>([]);
  const [orderId, setOrderId] = useState("ord_1");
  const [incidentType, setIncidentType] = useState("customerReturn14d");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.incidentsGetIncidents(reqId("inc-list"));
    if (res.ok) setRows(res.rows);
    else setError({ message: res.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const createIncident = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.incidentsCreateIncident(reqId("inc-create"), { orderId, incidentType });
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  const processIncident = async (id: number) => {
    setLoading(true);
    setError(null);
    const res = await transport.incidentsProcessIncident(reqId("inc-process"), id);
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Incidents Write Workflows</Typography>
            <Chip label={`Rows: ${rows.length}`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}

          <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
            <TextField size="small" label="Order ID" value={orderId} onChange={(e) => setOrderId(e.target.value)} />
            <TextField size="small" label="Incident type" value={incidentType} onChange={(e) => setIncidentType(e.target.value)} />
            <Button size="small" variant="contained" onClick={createIncident} disabled={loading}>
              Create incident
            </Button>
          </Stack>

          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Order</TableCell>
                  <TableCell>Status</TableCell>
                  <TableCell align="right">Action</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {rows.slice(0, 10).map((r) => (
                  <TableRow key={r.id}>
                    <TableCell>{r.id}</TableCell>
                    <TableCell>{r.orderId}</TableCell>
                    <TableCell>{r.status}</TableCell>
                    <TableCell align="right">
                      <Button size="small" onClick={() => processIncident(r.id)} disabled={loading || r.status === "resolved"}>
                        Process
                      </Button>
                    </TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Stack>
      </CardContent>
    </Card>
  );
}

export function CapitalWorkflowPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [balance, setBalance] = useState<number>(0);
  const [entries, setEntries] = useState<LedgerEntryView[]>([]);
  const [amount, setAmount] = useState("100");
  const [note, setNote] = useState("");
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.capitalGetSnapshot(reqId("capital-snapshot"));
    if (res.ok) {
      setBalance(res.snapshot.balance);
      setEntries(
        res.snapshot.entriesRecent.map((e) => ({
          id: e.id,
          type: e.type,
          amount: e.amount,
        })),
      );
    } else setError({ message: res.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const record = async () => {
    const parsed = Number(amount);
    if (!Number.isFinite(parsed) || parsed === 0) {
      setError({ message: "Amount must be non-zero" });
      return;
    }
    setLoading(true);
    setError(null);
    const res = await transport.capitalRecordAdjustment(reqId("capital-adjust"), {
      amount: parsed,
      referenceId: note.trim() || null,
      currency: "PLN",
    });
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Capital Write Workflows</Typography>
            <Chip label={`Balance: ${balance.toFixed(2)} PLN`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}
          <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
            <TextField size="small" label="Amount" value={amount} onChange={(e) => setAmount(e.target.value)} />
            <TextField size="small" label="Note" value={note} onChange={(e) => setNote(e.target.value)} />
            <Button size="small" variant="contained" onClick={record} disabled={loading}>
              Record adjustment
            </Button>
          </Stack>
          <Typography variant="subtitle2">Recent ledger entries</Typography>
          <TableContainer>
            <Table size="small">
              <TableHead>
                <TableRow>
                  <TableCell>ID</TableCell>
                  <TableCell>Type</TableCell>
                  <TableCell align="right">Amount</TableCell>
                </TableRow>
              </TableHead>
              <TableBody>
                {entries.slice(0, 8).map((e) => (
                  <TableRow key={e.id}>
                    <TableCell>{e.id}</TableCell>
                    <TableCell>{e.type}</TableCell>
                    <TableCell align="right">{e.amount.toFixed(2)}</TableCell>
                  </TableRow>
                ))}
              </TableBody>
            </Table>
          </TableContainer>
        </Stack>
      </CardContent>
    </Card>
  );
}

type LedgerEntryView = {
  id: number;
  type: string;
  amount: number;
};

export function ReturnPoliciesWorkflowPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [rows, setRows] = useState<SupplierReturnPolicy[]>([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);
  const [supplierId, setSupplierId] = useState("sup_1");
  const [policyType, setPolicyType] = useState<SupplierReturnPolicy["policyType"]>("returnWindow");
  const [windowDays, setWindowDays] = useState("14");

  const load = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.policiesGetAll(reqId("policies-list"));
    if (res.ok) setRows(res.rows);
    else setError({ message: res.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const save = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.policiesUpsert(reqId("policies-upsert"), {
      policy: {
        supplierId,
        policyType,
        returnWindowDays: Number.isFinite(Number(windowDays)) ? Number(windowDays) : null,
        restockingFeePercent: 5,
        returnShippingPaidBy: "supplier",
        requiresRma: false,
        warehouseReturnSupported: true,
        virtualRestockSupported: false,
      },
    });
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Return Policies Write Workflows</Typography>
            <Chip label={`Policies: ${rows.length}`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}
          <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
            <TextField size="small" label="Supplier ID" value={supplierId} onChange={(e) => setSupplierId(e.target.value)} />
            <FormControl size="small" sx={{ minWidth: 180 }}>
              <InputLabel>Policy type</InputLabel>
              <Select
                value={policyType}
                label="Policy type"
                onChange={(e) => setPolicyType(e.target.value as SupplierReturnPolicy["policyType"])}
              >
                {["noReturns", "defectOnly", "returnWindow", "fullReturns", "returnToWarehouse", "sellerHandlesReturns"].map((t) => (
                  <MenuItem key={t} value={t}>
                    {t}
                  </MenuItem>
                ))}
              </Select>
            </FormControl>
            <TextField size="small" label="Window days" value={windowDays} onChange={(e) => setWindowDays(e.target.value)} />
            <Button size="small" variant="contained" onClick={save} disabled={loading}>
              Save policy
            </Button>
          </Stack>
        </Stack>
      </CardContent>
    </Card>
  );
}

export function SupplierReliabilityAndRiskPanel() {
  const transport = useMemo(() => getAdminTransport(), []);
  const [suppliers, setSuppliers] = useState<SupplierRow[]>([]);
  const [risk, setRisk] = useState<RiskDashboardSnapshot | null>(null);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState<ApiError | null>(null);

  const load = async () => {
    setLoading(true);
    setError(null);
    const [sRes, rRes] = await Promise.all([
      transport.suppliersGetSuppliers(reqId("suppliers-list")),
      transport.riskGetDashboardSnapshot(reqId("risk-snapshot")),
    ]);
    if (sRes.ok) setSuppliers(sRes.rows);
    else setError({ message: sRes.error.message });
    if (rRes.ok) setRisk(rRes.snapshot);
    else setError((prev) => prev ?? { message: rRes.error.message });
    setLoading(false);
  };

  // eslint-disable-next-line react-hooks/set-state-in-effect, react-hooks/exhaustive-deps
  useEffect(() => { load(); }, []);

  const refreshReliability = async () => {
    setLoading(true);
    setError(null);
    const res = await transport.suppliersRefreshReliabilityScores(reqId("suppliers-refresh"), { windowDays: 90 });
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  const refreshRisk = async (kind: "listingHealth" | "customerMetrics") => {
    setLoading(true);
    setError(null);
    const res =
      kind === "listingHealth"
        ? await transport.riskRefreshListingHealth(reqId("risk-health"), { windowDays: 90 })
        : await transport.riskRefreshCustomerMetrics(reqId("risk-customer"), { windowDays: 90 });
    if (!res.ok) setError({ message: res.error.message });
    await load();
    setLoading(false);
  };

  return (
    <Card>
      <CardContent>
        <Stack spacing={1.5}>
          <Stack direction="row" spacing={1} alignItems="center">
            <Typography variant="h6">Suppliers Reliability + Risk Refresh Actions</Typography>
            <Chip label={`Suppliers: ${suppliers.length}`} size="small" />
            <Button size="small" variant="outlined" onClick={load} disabled={loading}>
              {loading ? "Loading..." : "Refresh"}
            </Button>
          </Stack>
          {error ? <Alert severity="warning">{toMessage(error)}</Alert> : null}
          <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
            <Button size="small" variant="contained" onClick={refreshReliability} disabled={loading}>
              Refresh reliability scores
            </Button>
            <Button size="small" variant="outlined" onClick={() => refreshRisk("listingHealth")} disabled={loading}>
              Refresh listing health
            </Button>
            <Button size="small" variant="outlined" onClick={() => refreshRisk("customerMetrics")} disabled={loading}>
              Refresh customer metrics
            </Button>
          </Stack>
          {risk ? (
            <Stack direction="row" spacing={1} useFlexGap flexWrap="wrap">
              <Chip label={`Negative margin: ${risk.negativeMarginListings ?? 0}`} />
              <Chip label={`Paused: ${risk.pausedListings ?? 0}`} />
              <Chip label={`Alerts: ${risk.listingHealthAlerts ?? 0}`} />
            </Stack>
          ) : null}
        </Stack>
      </CardContent>
    </Card>
  );
}

