// Live-traffic overlay. Tiles are requested from the OpenFamily server
// (GET /traffic/tiles/z/x/y) with the panel's signed-in API client, so the
// traffic provider's key never reaches the browser.

import L from "leaflet";
import { getTrafficTile } from "../lib/api";

/** Wraps a tile column into the valid range for the zoom, or null when the row is off the map. */
export function normalizeTile(z: number, x: number, y: number): { z: number; x: number; y: number } | null {
  const n = 2 ** z;
  if (y < 0 || y >= n) return null;
  return { z, x: ((x % n) + n) % n, y };
}

export class TrafficTileLayer extends L.GridLayer {
  createTile(coords: L.Coords, done: L.DoneCallback): HTMLElement {
    const tile = document.createElement("img");
    tile.alt = "";
    tile.setAttribute("role", "presentation");
    const target = normalizeTile(coords.z, coords.x, coords.y);
    if (!target) {
      window.setTimeout(() => done(undefined, tile), 0);
      return tile;
    }
    getTrafficTile(target.z, target.x, target.y)
      .then((blob) => {
        const url = URL.createObjectURL(blob);
        tile.onload = () => {
          URL.revokeObjectURL(url);
          done(undefined, tile);
        };
        tile.onerror = () => {
          URL.revokeObjectURL(url);
          done(new Error("traffic tile failed to decode"), tile);
        };
        tile.src = url;
      })
      .catch((error: unknown) => done(error instanceof Error ? error : new Error("traffic tile failed"), tile));
    return tile;
  }
}
