"use client";

import {
  Box,
  Card,
  CardContent,
  Chip,
  Stack,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  Typography,
} from "@mui/material";

type RowModel = {
  orderId: string;
  platform: string;
  status: "pending" | "shipped" | "failed";
  profit: number;
  risk: number; // 0-100
};

function statusChip(status: RowModel["status"]) {
  switch (status) {
    case "shipped":
      return { label: "Shipped", sx: { bgcolor: "rgba(46,125,50,0.10)", color: "#1B5E20", borderColor: "rgba(46,125,50,0.25)" } };
    case "failed":
      return { label: "Failed", sx: { bgcolor: "rgba(211,47,47,0.10)", color: "#B71C1C", borderColor: "rgba(211,47,47,0.25)" } };
    case "pending":
    default:
      return { label: "Pending", sx: { bgcolor: "rgba(237,108,2,0.12)", color: "#E65C00", borderColor: "rgba(237,108,2,0.30)" } };
  }
}

export function RecentOrdersTableCard({ rows }: { rows: RowModel[] }) {
  return (
    <Card>
      <CardContent>
        <Stack direction="row" alignItems="baseline" justifyContent="space-between" sx={{ mb: 1.5 }}>
          <Typography variant="h6" sx={{ fontWeight: 950 }}>
            Recent orders
          </Typography>
          <Typography variant="body2" color="text.secondary">
            Latest 8
          </Typography>
        </Stack>

        <TableContainer sx={{ borderRadius: 3, border: "1px solid rgba(16,24,40,0.06)" }}>
          <Table size="small">
            <TableHead>
              <TableRow>
                <TableCell sx={{ fontWeight: 900, color: "text.secondary" }}>Order</TableCell>
                <TableCell sx={{ fontWeight: 900, color: "text.secondary" }}>Platform</TableCell>
                <TableCell sx={{ fontWeight: 900, color: "text.secondary" }}>Status</TableCell>
                <TableCell sx={{ fontWeight: 900, color: "text.secondary", textAlign: "right" }}>Profit</TableCell>
                <TableCell sx={{ fontWeight: 900, color: "text.secondary", textAlign: "right" }}>Risk</TableCell>
              </TableRow>
            </TableHead>
            <TableBody>
              {rows.map((r) => {
                const chip = statusChip(r.status);
                return (
                  <TableRow key={r.orderId} hover>
                    <TableCell>
                      <Typography sx={{ fontWeight: 900 }}>{r.orderId}</Typography>
                    </TableCell>
                    <TableCell>{r.platform}</TableCell>
                    <TableCell>
                      <Chip
                        label={chip.label}
                        variant="outlined"
                        sx={{ fontWeight: 950, ...chip.sx, borderWidth: 1 }}
                      />
                    </TableCell>
                    <TableCell sx={{ textAlign: "right" }}>
                      <Typography sx={{ fontWeight: 900, color: r.profit >= 0 ? "#1B5E20" : "#B71C1C" }}>
                        {r.profit >= 0 ? "+" : ""}
                        {r.profit.toFixed(0)} PLN
                      </Typography>
                    </TableCell>
                    <TableCell sx={{ textAlign: "right" }}>
                      <Box sx={{ display: "inline-flex", alignItems: "center", gap: 1 }}>
                        <Typography sx={{ fontWeight: 900 }}>{r.risk}</Typography>
                        <Chip
                          label={r.risk >= 70 ? "High" : r.risk >= 40 ? "Med" : "Low"}
                          variant="outlined"
                          sx={{
                            fontWeight: 950,
                            borderWidth: 1,
                            borderColor: r.risk >= 70 ? "rgba(211,47,47,0.25)" : r.risk >= 40 ? "rgba(237,108,2,0.30)" : "rgba(46,125,50,0.25)",
                            bgcolor:
                              r.risk >= 70
                                ? "rgba(211,47,47,0.08)"
                                : r.risk >= 40
                                  ? "rgba(237,108,2,0.10)"
                                  : "rgba(46,125,50,0.09)",
                          }}
                        />
                      </Box>
                    </TableCell>
                  </TableRow>
                );
              })}
            </TableBody>
          </Table>
        </TableContainer>
      </CardContent>
    </Card>
  );
}

