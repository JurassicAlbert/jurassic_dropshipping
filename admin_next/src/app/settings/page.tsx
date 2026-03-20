import { AdminShell } from "@/components/AdminShell";
import { Box, Stack, Typography } from "@mui/material";

export default function SettingsPage() {
  return (
    <AdminShell>
      <Stack spacing={2.5}>
        <Box>
          <Typography variant="h4" sx={{ fontWeight: 950 }}>
            Settings
          </Typography>
          <Typography color="text.secondary" sx={{ mt: 0.5 }}>
            Next step: connect to your existing rules storage + feature flags.
          </Typography>
        </Box>
      </Stack>
    </AdminShell>
  );
}

