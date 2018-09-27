import { BaseIncomingMessage, HTTPServiceMapParams } from "@app/types";
import { BandResponse, response } from "@rockstat/rock-me-ts";
import { IN_GENERIC, SERVICE_PIXEL } from "@app/constants";
import { Dispatcher } from "@app/Dispatcher";
import { epglue } from "@app/helpers";

export const pixelHandler = (disp: Dispatcher) => {
  const handler = async (key: string, msg: BaseIncomingMessage): Promise<BandResponse> => {
    console.log(msg)
    return response.pixel({})
  }

  disp.handleBus.subscribe(epglue(IN_GENERIC, SERVICE_PIXEL), handler);

}
