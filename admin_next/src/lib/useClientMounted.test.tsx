import { render, screen, waitFor } from "@testing-library/react";
import { describe, expect, it } from "vitest";
import { useClientMounted } from "./useClientMounted";

function Probe() {
  const m = useClientMounted();
  return <span data-testid="m">{m ? "yes" : "no"}</span>;
}

describe("useClientMounted", () => {
  it("is true after mount (client-only chart gating)", async () => {
    render(<Probe />);
    await waitFor(() => {
      expect(screen.getByTestId("m")).toHaveTextContent("yes");
    });
  });
});
