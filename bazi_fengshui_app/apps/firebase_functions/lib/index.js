"use strict";
// Minimal entry point for Cloud Functions exports.
// All function implementations are isolated in their respective modules.
// Keep this file clean: only export functions, do not define them here.
Object.defineProperty(exports, "__esModule", { value: true });
exports.resetMonthlyQuota = exports.createChart = void 0;
var createChart_1 = require("./callable/createChart");
Object.defineProperty(exports, "createChart", { enumerable: true, get: function () { return createChart_1.createChart; } });
var resetMonthlyQuota_1 = require("./tasks/resetMonthlyQuota");
Object.defineProperty(exports, "resetMonthlyQuota", { enumerable: true, get: function () { return resetMonthlyQuota_1.resetMonthlyQuota; } });
// NOTE: Implementations live in src/callable/* and src/tasks/*
//# sourceMappingURL=index.js.map