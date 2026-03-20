"use client";

import {
  AppBar,
  Avatar,
  Box,
  Divider,
  Drawer,
  IconButton,
  List,
  ListItemButton,
  ListItemIcon,
  ListItemText,
  Stack,
  Toolbar,
  Typography,
  TextField,
} from "@mui/material";
import type { ReactNode } from "react";
import Link from "next/link";
import { usePathname } from "next/navigation";
import DashboardRoundedIcon from "@mui/icons-material/DashboardRounded";
import AnalyticsRoundedIcon from "@mui/icons-material/AnalyticsRounded";
import Inventory2RoundedIcon from "@mui/icons-material/Inventory2Rounded";
import ShoppingCartRoundedIcon from "@mui/icons-material/ShoppingCartRounded";
import StoreRoundedIcon from "@mui/icons-material/StoreRounded";
import SettingsRoundedIcon from "@mui/icons-material/SettingsRounded";
import SearchRoundedIcon from "@mui/icons-material/SearchRounded";
import NotificationsNoneRoundedIcon from "@mui/icons-material/NotificationsNoneRounded";
import AssignmentTurnedInRoundedIcon from "@mui/icons-material/AssignmentTurnedInRounded";
import TrendingUpRoundedIcon from "@mui/icons-material/TrendingUpRounded";
import LocalShippingRoundedIcon from "@mui/icons-material/LocalShippingRounded";
import WarningAmberRoundedIcon from "@mui/icons-material/WarningAmberRounded";
import AccountBalanceWalletRoundedIcon from "@mui/icons-material/AccountBalanceWalletRounded";
import GavelRoundedIcon from "@mui/icons-material/GavelRounded";
import HistoryEduRoundedIcon from "@mui/icons-material/HistoryEduRounded";
import AutoGraphRoundedIcon from "@mui/icons-material/AutoGraphRounded";
import HelpOutlineRoundedIcon from "@mui/icons-material/HelpOutlineRounded";

const drawerWidth = 280;

type NavItem = { label: string; icon: ReactNode; href: string };

const main: NavItem[] = [
  { label: "Dashboard", icon: <DashboardRoundedIcon />, href: "/" },
  { label: "Analytics", icon: <AnalyticsRoundedIcon />, href: "/analytics" },
  { label: "Profit Dashboard", icon: <AutoGraphRoundedIcon />, href: "/profit-dashboard" },
  { label: "Products", icon: <Inventory2RoundedIcon />, href: "/products" },
  { label: "Orders", icon: <ShoppingCartRoundedIcon />, href: "/orders" },
  { label: "Suppliers", icon: <StoreRoundedIcon />, href: "/suppliers" },
  { label: "Marketplaces", icon: <TrendingUpRoundedIcon />, href: "/marketplaces" },
  { label: "Returns", icon: <LocalShippingRoundedIcon />, href: "/returns" },
  { label: "Incidents", icon: <WarningAmberRoundedIcon />, href: "/incidents" },
  { label: "Risk Dashboard", icon: <WarningAmberRoundedIcon />, href: "/risk-dashboard" },
  { label: "Returned Stock", icon: <Inventory2RoundedIcon />, href: "/returned-stock" },
  { label: "Capital", icon: <AccountBalanceWalletRoundedIcon />, href: "/capital" },
  { label: "Approval", icon: <AssignmentTurnedInRoundedIcon />, href: "/approval" },
  { label: "Decision Log", icon: <HistoryEduRoundedIcon />, href: "/decision-log" },
  { label: "Return Policies", icon: <GavelRoundedIcon />, href: "/return-policies" },
  { label: "How It Works", icon: <HelpOutlineRoundedIcon />, href: "/how-it-works" },
];

export function AdminShell({ children }: { children: React.ReactNode }) {
  const pathname = usePathname();

  const isActive = (href: string) => {
    if (href === "/") return pathname === "/";
    return pathname?.startsWith(href);
  };

  return (
    <Box sx={{ display: "flex", minHeight: "100vh", bgcolor: "background.default" }}>
      <AppBar
        position="fixed"
        elevation={0}
        color="transparent"
        sx={{
          backdropFilter: "saturate(180%) blur(10px)",
          borderBottom: "1px solid rgba(16,24,40,0.06)",
        }}
      >
        <Toolbar sx={{ pl: `${drawerWidth}px` }}>
          <Stack direction="row" spacing={1.5} alignItems="center" sx={{ flex: 1 }}>
            <Typography variant="h6">Jurassic Admin</Typography>
          </Stack>

          <Box sx={{ display: "flex", alignItems: "center", gap: 1, mr: 1.5 }}>
            <TextField
              size="small"
              placeholder="Search…"
              variant="outlined"
              sx={{
                width: 280,
                "& .MuiOutlinedInput-root": {
                  borderRadius: 999,
                  bgcolor: "rgba(255,255,255,0.6)",
                },
              }}
              InputProps={{
                startAdornment: (
                  <IconButton size="small" aria-label="search" sx={{ mr: 0.5 }}>
                    <SearchRoundedIcon fontSize="small" />
                  </IconButton>
                ),
              }}
            />
          </Box>

          <IconButton aria-label="notifications">
            <NotificationsNoneRoundedIcon />
          </IconButton>
          <Avatar sx={{ ml: 1.5, width: 32, height: 32 }}>A</Avatar>
        </Toolbar>
      </AppBar>

      <Drawer
        variant="permanent"
        sx={{
          width: drawerWidth,
          flexShrink: 0,
          [`& .MuiDrawer-paper`]: {
            width: drawerWidth,
            boxSizing: "border-box",
            borderRight: "1px solid rgba(16,24,40,0.06)",
            bgcolor: "background.paper",
          },
        }}
      >
        <Toolbar />
        <Box sx={{ px: 2, pb: 2 }}>
          <Typography variant="subtitle2" color="text.secondary" sx={{ px: 1, py: 1 }}>
            MAIN
          </Typography>
          <List disablePadding sx={{ display: "grid", gap: 0.5 }}>
            {main.map((item) => (
              <ListItemButton
                key={item.href}
                component={Link}
                href={item.href}
                sx={{
                  py: 1.1,
                  px: 1.25,
                  bgcolor: isActive(item.href) ? "rgba(28,110,242,0.08)" : "transparent",
                  "&:hover": { bgcolor: isActive(item.href) ? "rgba(28,110,242,0.12)" : "rgba(16,24,40,0.04)" },
                }}
              >
                <ListItemIcon sx={{ minWidth: 40 }}>{item.icon}</ListItemIcon>
                <ListItemText
                  primary={item.label}
                  primaryTypographyProps={{ fontWeight: isActive(item.href) ? 900 : 700 }}
                />
              </ListItemButton>
            ))}
          </List>

          <Divider sx={{ my: 2 }} />
          <Typography variant="subtitle2" color="text.secondary" sx={{ px: 1, py: 1 }}>
            ADMIN
          </Typography>
          <List disablePadding sx={{ display: "grid", gap: 0.5 }}>
            <ListItemButton
              component={Link}
              href="/settings"
              sx={{
                py: 1.1,
                px: 1.25,
                bgcolor: isActive("/settings") ? "rgba(28,110,242,0.08)" : "transparent",
                "&:hover": { bgcolor: isActive("/settings") ? "rgba(28,110,242,0.12)" : "rgba(16,24,40,0.04)" },
              }}
            >
              <ListItemIcon sx={{ minWidth: 40 }}>
                <SettingsRoundedIcon />
              </ListItemIcon>
              <ListItemText
                primary="Settings"
                primaryTypographyProps={{ fontWeight: isActive("/settings") ? 900 : 700 }}
              />
            </ListItemButton>
          </List>
        </Box>
      </Drawer>

      <Box component="main" sx={{ flex: 1 }}>
        <Toolbar />
        <Box sx={{ p: 3 }}>{children}</Box>
      </Box>
    </Box>
  );
}

