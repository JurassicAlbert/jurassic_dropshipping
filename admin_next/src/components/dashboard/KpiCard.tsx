"use client";

import { Card, CardContent, Chip, Stack, Typography } from "@mui/material";
import type { ChipProps } from "@mui/material/Chip";

export type KpiCardModel = {
  label: string;
  value: string;
  delta: string;
  chipVariant?: ChipProps["variant"];
  chipTone?: "success" | "warning" | "error" | "primary";
};

function toneToSx(tone?: KpiCardModel["chipTone"]) {
  switch (tone) {
    case "success":
      return { bgcolor: "rgba(46, 125, 50, 0.10)", color: "#1B5E20", borderColor: "rgba(46,125,50,0.25)" };
    case "warning":
      return { bgcolor: "rgba(237, 108, 2, 0.12)", color: "#E65C00", borderColor: "rgba(237,108,2,0.30)" };
    case "error":
      return { bgcolor: "rgba(211, 47, 47, 0.10)", color: "#B71C1C", borderColor: "rgba(211,47,47,0.25)" };
    case "primary":
    default:
      return { bgcolor: "rgba(28,110,242,0.08)", color: "#1C6EF2", borderColor: "rgba(28,110,242,0.25)" };
  }
}

export function KpiCard({ label, value, delta, chipTone, chipVariant = "outlined" }: KpiCardModel) {
  return (
    <Card>
      <CardContent>
        <Stack direction="row" justifyContent="space-between" alignItems="flex-start">
          <Stack spacing={0.25}>
            <Typography variant="subtitle2" color="text.secondary">
              {label}
            </Typography>
            <Typography variant="h5" sx={{ mt: 0.25 }}>
              {value}
            </Typography>
          </Stack>

          <Chip
            label={delta}
            variant={chipVariant}
            sx={{
              fontWeight: 900,
              borderRadius: 999,
              ...toneToSx(chipTone),
            }}
          />
        </Stack>
      </CardContent>
    </Card>
  );
}

