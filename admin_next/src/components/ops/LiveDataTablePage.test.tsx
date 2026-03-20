import { render, screen, waitFor } from "@testing-library/react";
import { LiveDataTablePage } from "./LiveDataTablePage";

describe("LiveDataTablePage", () => {
  it("renders rows and summary from API", async () => {
    vi.stubGlobal(
      "fetch",
      vi.fn(async () => ({
        ok: true,
        json: async () => ({
          summary: { total: 2 },
          rows: [
            { id: "a1", status: "open" },
            { id: "a2", status: "closed" },
          ],
        }),
      })) as unknown as typeof fetch,
    );

    render(
      <LiveDataTablePage
        title="Incidents"
        subtitle="Test subtitle"
        apiPath="/api/incidents"
      />,
    );

    expect(screen.getByText("Incidents")).toBeInTheDocument();
    await waitFor(() => expect(screen.getByText("a1")).toBeInTheDocument());
    expect(screen.getByText("rows: 2")).toBeInTheDocument();
  });
});

