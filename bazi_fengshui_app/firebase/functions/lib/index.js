"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.createChart = exports.resetMonthlyQuota = void 0;
// This file should only re-export functions.
// Keep function-specific initialization (e.g. admin.initializeApp()) inside the modules that need it
// to avoid double initialization and to keep this file minimal for re-exports.
var resetMonthlyQuota_1 = require("./tasks/resetMonthlyQuota");
Object.defineProperty(exports, "resetMonthlyQuota", { enumerable: true, get: function () { return resetMonthlyQuota_1.resetMonthlyQuota; } });
var createChart_1 = require("./callable/createChart");
Object.defineProperty(exports, "createChart", { enumerable: true, get: function () { return createChart_1.createChart; } });
//# sourceMappingURL=index.js.map