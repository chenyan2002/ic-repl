#!/ic-repl
import wallet = "${WALLET_ID:-rwlgt-iiaaa-aaaaa-aaaaa-cai}" as "wallet.did";
identity default "~/.config/dfx/identity/default/identity.pem";
call wallet.wallet_create_canister(
  record {
    cycles = ${CYCLE:-1_000_000};
    settings = record {
      controller = null;
      freezing_threshold = null;
      memory_allocation = null;
      compute_allocation = null;
    }
  },
);
let id = _.Ok.canister_id;

call as wallet ic.install_code(
  record {
    arg = encode ();
    wasm_module = file "${WASM_FILE}";
    mode = variant { install };
    canister_id = id;
  },
);

/*
let msg = encode ic.install_code(
  record {
    arg = encode ();
    wasm_module = file "${WASM_FILE}";
    mode = variant { install };
    canister_id = id;
  },
);
let res = call wallet.wallet_call(
  record {
    args = msg;
    cycles = 0;
    method_name = "install_code";
    canister = ic;
  },
);
decode as ic.install_code res.Ok.return;
*/
