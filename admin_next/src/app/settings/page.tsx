"use client";

import { useCallback, useEffect, useState } from "react";
import { AdminShell } from "@/components/AdminShell";
import {
  Alert,
  Box,
  Button,
  Card,
  CardContent,
  Divider,
  FormControlLabel,
  Stack,
  Switch,
  TextField,
  Typography,
} from "@mui/material";

export default function SettingsPage() {
  const [rules, setRules] = useState<Record<string, unknown> | null>(null);
  const [loading, setLoading] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);
  const [savedOk, setSavedOk] = useState(false);

  const load = useCallback(async () => {
    setLoading(true);
    setError(null);
    setSavedOk(false);
    try {
      const res = await fetch("/api/rules", { cache: "no-store" });
      if (!res.ok) {
        setError(`Could not load rules (${res.status}). Is the Dart dashboard API running?`);
        setRules(null);
        return;
      }
      const json = (await res.json()) as Record<string, unknown>;
      setRules(json);
    } catch {
      setError("Could not reach /api/rules. Start the Dart API or check DART_API_BASE_URL.");
      setRules(null);
    } finally {
      setLoading(false);
    }
  }, []);

  useEffect(() => {
    void load();
  }, [load]);

  const save = async () => {
    if (!rules) return;
    setSaving(true);
    setError(null);
    setSavedOk(false);
    try {
      const res = await fetch("/api/rules", {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(rules),
      });
      if (!res.ok) {
        setError(`Save failed (${res.status})`);
        return;
      }
      const json = (await res.json()) as Record<string, unknown>;
      setRules(json);
      setSavedOk(true);
    } catch {
      setError("Save failed — API unreachable.");
    } finally {
      setSaving(false);
    }
  };

  const patch = (partial: Record<string, unknown>) => {
    setRules((r) => (r ? { ...r, ...partial } : null));
    setSavedOk(false);
  };

  const num = (k: string, fallback: number) => {
    const v = rules?.[k];
    return typeof v === "number" && !Number.isNaN(v) ? v : fallback;
  };

  const bool = (k: string) => Boolean(rules?.[k]);

  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Settings
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Rules and feature flags (same storage as the Flutter app — Drift user_rules via Dart API).
          </Typography>
          {loading ? (
            <Typography color="text.secondary" sx={{ mt: 0.5 }}>
              Loading rules…
            </Typography>
          ) : null}
          {error ? (
            <Alert severity="warning" sx={{ mt: 1.5 }}>
              {error}
            </Alert>
          ) : null}
          {savedOk ? (
            <Alert severity="success" sx={{ mt: 1.5 }}>
              Saved.
            </Alert>
          ) : null}
        </Box>

        <Card>
          <CardContent>
            <Stack spacing={2}>
              <Typography variant="subtitle1" sx={{ fontWeight: 800 }}>
                Approvals &amp; automation
              </Typography>
              <FormControlLabel
                control={
                  <Switch
                    checked={bool("manualApprovalListings")}
                    onChange={(_, v) => patch({ manualApprovalListings: v })}
                    disabled={!rules}
                  />
                }
                label="Manual approval for new listings"
              />
              <FormControlLabel
                control={
                  <Switch
                    checked={bool("manualApprovalOrders")}
                    onChange={(_, v) => patch({ manualApprovalOrders: v })}
                    disabled={!rules}
                  />
                }
                label="Manual approval for orders (before fulfillment)"
              />
              <FormControlLabel
                control={
                  <Switch
                    checked={bool("targetsReadOnly")}
                    onChange={(_, v) => patch({ targetsReadOnly: v })}
                    disabled={!rules}
                  />
                }
                label="Targets read-only (dry-run — no marketplace writes)"
              />
              <FormControlLabel
                control={
                  <Switch
                    checked={bool("kpiDrivenStrategyEnabled")}
                    onChange={(_, v) => patch({ kpiDrivenStrategyEnabled: v })}
                    disabled={!rules}
                  />
                }
                label="KPI-driven pricing strategy (feature)"
              />
              <Divider />
              <TextField
                label="Min profit %"
                type="number"
                value={num("minProfitPercent", 25)}
                onChange={(e) => patch({ minProfitPercent: Number(e.target.value) })}
                disabled={!rules}
                size="small"
                inputProps={{ step: 0.5 }}
              />
              <TextField
                label="Default markup %"
                type="number"
                value={num("defaultMarkupPercent", 30)}
                onChange={(e) => patch({ defaultMarkupPercent: Number(e.target.value) })}
                disabled={!rules}
                size="small"
                inputProps={{ step: 0.5 }}
              />
              <TextField
                label="Scan interval (minutes)"
                type="number"
                value={num("scanIntervalMinutes", 1440)}
                onChange={(e) =>
                  patch({ scanIntervalMinutes: Math.max(1, Math.floor(Number(e.target.value))) })
                }
                disabled={!rules}
                size="small"
              />
              <Button variant="contained" onClick={() => void save()} disabled={!rules || saving}>
                {saving ? "Saving…" : "Save rules"}
              </Button>
              <Button variant="outlined" onClick={() => void load()} disabled={loading}>
                Reload
              </Button>
            </Stack>
          </CardContent>
        </Card>
      </Stack>
    </AdminShell>
  );
}
