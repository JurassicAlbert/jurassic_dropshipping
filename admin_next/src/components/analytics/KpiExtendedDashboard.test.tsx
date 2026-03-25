import { render, screen } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import type { DashboardApiPayload } from "@/lib/dashboardApi";
import { DASHBOARD_OFFLINE_FALLBACK } from "@/lib/dashboardApi";
import { CustomerMessagingPlaceholder, MarketListingPlaceholder } from "./KpiExtendedDashboard";

function baseView(over: Partial<DashboardApiPayload> = {}): DashboardApiPayload {
  return { ...DASHBOARD_OFFLINE_FALLBACK, ...over };
}

describe("KpiExtendedDashboard p11 / p13", () => {
  describe("CustomerMessagingPlaceholder", () => {
    it("renders deferred state when hasData is false and no note (generic copy)", () => {
      const view = baseView({
        customerMessaging: { hasData: false },
      });
      render(<CustomerMessagingPlaceholder view={view} />);
      expect(screen.getByTestId("analytics-p11-customer-messaging")).toHaveAttribute("data-p11-state", "deferred");
      expect(screen.getByText(/Messaging KPIs deferred/i)).toBeInTheDocument();
    });

    it("renders deferred state with offline snapshot note when present", () => {
      const view = baseView();
      render(<CustomerMessagingPlaceholder view={view} />);
      expect(screen.getByTestId("analytics-p11-customer-messaging")).toHaveAttribute("data-p11-state", "deferred");
      expect(screen.getByText(/Wire customer\/message tables/i)).toBeInTheDocument();
    });

    it("shows API note in deferred state", () => {
      const view = baseView({
        customerMessaging: { hasData: false, note: "Custom note from API." },
      });
      render(<CustomerMessagingPlaceholder view={view} />);
      expect(screen.getByText("Custom note from API.")).toBeInTheDocument();
    });

    it("shows ready state when hasData is true", () => {
      const view = baseView({
        customerMessaging: { hasData: true, note: "Optional detail." },
      });
      render(<CustomerMessagingPlaceholder view={view} />);
      expect(screen.getByTestId("analytics-p11-customer-messaging")).toHaveAttribute("data-p11-state", "ready");
      expect(screen.getByText(/Messaging aggregates/i)).toBeInTheDocument();
      expect(screen.getByText("Optional detail.")).toBeInTheDocument();
    });
  });

  describe("MarketListingPlaceholder", () => {
    it("renders deferred state when competitiveness and conversion are null", () => {
      const view = baseView({
        marketListing: {
          priceCompetitivenessIndex: null,
          listingConversionRate: null,
          note: "Needs feeds.",
        },
      });
      render(<MarketListingPlaceholder view={view} />);
      expect(screen.getByTestId("analytics-p13-market-listing")).toHaveAttribute("data-p13-state", "deferred");
      expect(screen.getByText("Needs feeds.")).toBeInTheDocument();
    });

    it("shows metrics state when at least one metric is present", () => {
      const view = baseView({
        marketListing: {
          priceCompetitivenessIndex: 0.82,
          listingConversionRate: null,
          note: "Sample row.",
        },
      });
      render(<MarketListingPlaceholder view={view} />);
      expect(screen.getByTestId("analytics-p13-market-listing")).toHaveAttribute("data-p13-state", "metrics");
      expect(screen.getByText(/0\.82/)).toBeInTheDocument();
      expect(screen.getByText("Sample row.")).toBeInTheDocument();
    });

    it("formats listing conversion as percent when set", () => {
      const view = baseView({
        marketListing: {
          priceCompetitivenessIndex: null,
          listingConversionRate: 0.125,
        },
      });
      render(<MarketListingPlaceholder view={view} />);
      expect(screen.getByText(/12\.5%/)).toBeInTheDocument();
    });
  });
});
