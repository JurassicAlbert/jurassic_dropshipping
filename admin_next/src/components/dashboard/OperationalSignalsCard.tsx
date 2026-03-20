"use client";

import { Card, CardContent, Stack, Typography } from "@mui/material";

type Signal = {
  title: string;
  subtitle: string;
  tone: "primary" | "warning" | "error";
};

function toneSx(tone: Signal["tone"]) {
  switch (tone) {
    case "warning":
      return { bgcolor: "rgba(237,108,2,0.06)", borderColor: "rgba(237,108,2,0.20)" };
    case "error":
      return { bgcolor: "rgba(211,47,47,0.05)", borderColor: "rgba(211,47,47,0.20)" };
    case "primary":
    default:
      return { bgcolor: "rgba(28,110,242,0.04)", borderColor: "rgba(28,110,242,0.18)" };
  }
}

export function OperationalSignalsCard({ signals }: { signals: Signal[] }) {
  return (
    <Card>
      <CardContent>
        <Typography variant="h6" sx={{ fontWeight: 950 }}>
          Operational signals
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5, mb: 2 }}>
          What needs attention right now.
        </Typography>

        <Stack spacing={1}>
          {signals.map((s) => (
            <Card
              key={s.title}
              variant="outlined"
              sx={{
                borderRadius: 14,
                ...toneSx(s.tone),
              }}
            >
              <CardContent>
                <Typography fontWeight={950}>{s.title}</Typography>
                <Typography color="text.secondary">{s.subtitle}</Typography>
              </CardContent>
            </Card>
          ))}
        </Stack>
      </CardContent>
    </Card>
  );
}

