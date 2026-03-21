/** Empty shapes when `/api/orders|products|suppliers` is unreachable — avoids red “API error” on every page. */

export type OrdersPayload = {
  summary: { total: number; queuedForCapital: number; statusCounts: Record<string, number> };
  rows: {
    id: string;
    targetOrderId: string;
    platform: string;
    listingId: string;
    status: string;
    quantity: number;
    sellingPrice: number;
    sourceCost: number;
    profit: number;
    riskScore?: number | null;
    queuedForCapital: boolean;
    createdAt?: string | null;
  }[];
};

export const ORDERS_OFFLINE: OrdersPayload = {
  summary: { total: 0, queuedForCapital: 0, statusCounts: {} },
  rows: [],
};

export type ProductsPayload = {
  summary: { total: number; withActiveListings: number };
  rows: {
    id: string;
    title: string;
    sourcePlatformId: string;
    supplierId?: string | null;
    supplierCountry?: string | null;
    basePrice: number;
    shippingCost?: number | null;
    currency: string;
    estimatedDays?: number | null;
    listingCount: number;
    activeListingCount: number;
    avgMarginPercent: number;
  }[];
};

export const PRODUCTS_OFFLINE: ProductsPayload = {
  summary: { total: 0, withActiveListings: 0 },
  rows: [],
};

export type SuppliersPayload = {
  summary: { total: number; withActiveListings: number };
  rows: {
    id: string;
    name: string;
    platformType: string;
    countryCode?: string | null;
    rating?: number | null;
    productsCount: number;
    listingsCount: number;
    activeListingsCount: number;
    ordersCount: number;
    returnsCount: number;
    avgOrderProfit: number;
  }[];
};

export const SUPPLIERS_OFFLINE: SuppliersPayload = {
  summary: { total: 0, withActiveListings: 0 },
  rows: [],
};
