"use client";

import { Card, CardContent, Chip, Stack, Typography } from "@mui/material";

export type AnalyticsIssue = {
  severity: "critical" | "warning" | "info";
  title: string;
  description: string;
  entityId?: string | null;
};

function toneSx(severity: AnalyticsIssue["severity"]) {
  switch (severity) {
    case "critical":
      return { bgcolor: "rgba(211,47,47,0.08)", color: "#B71C1C", borderColor: "rgba(211,47,47,0.25)" };
    case "warning":
      return { bgcolor: "rgba(237,108,2,0.10)", color: "#E65C00", borderColor: "rgba(237,108,2,0.30)" };
    case "info":
    default:
      return { bgcolor: "rgba(28,110,242,0.08)", color: "#1C6EF2", borderColor: "rgba(28,110,242,0.25)" };
  }
}

export function AnalyticsIssuesCard({ issues }: { issues: AnalyticsIssue[] }) {
  return (
    <Card>
      <CardContent>
        <Typography variant="h6" sx={{ fontWeight: 950 }}>
          Analytics issues
        </Typography>
        <Typography variant="body2" color="text.secondary" sx={{ mt: 0.5, mb: 2 }}>
          Engine-detected risks and anomalies.
        </Typography>

        <Stack spacing={1.25}>
          {issues.slice(0, 6).map((issue) => (
            <Card key={`${issue.title}-${issue.entityId ?? ""}`} variant="outlined" sx={{ borderRadius: 14 }}>
              <CardContent>
                <Stack direction="row" alignItems="center" justifyContent="space-between" sx={{ mb: 0.75 }}>
                  <Typography sx={{ fontWeight: 900 }}>{issue.title}</Typography>
                  <Chip label={issue.severity.toUpperCase()} variant="outlined" sx={{ fontWeight: 900, ...toneSx(issue.severity) }} />
                </Stack>
                <Typography color="text.secondary">{issue.description}</Typography>
              </CardContent>
            </Card>
          ))}
          {issues.length === 0 ? <Typography color="text.secondary">No active issues.</Typography> : null}
        </Stack>
      </CardContent>
    </Card>
  );
}

