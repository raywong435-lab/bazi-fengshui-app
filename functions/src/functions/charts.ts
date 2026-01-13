const { getCurrentEightCharJSON } = require('mystilight-8char');

interface ChartInputData {
  year: number;
  month: number;
  day: number;
  hour: number;
  gender: number; // 1 for male, 0 for female
}

export const createChart = async (data: ChartInputData) => {
  if (!data.year || !data.month || !data.day || !data.hour || data.gender === undefined) {
    throw new Error("必须提供完整的年月日时和性别信息。");
  }

  try {
    const chartData = getCurrentEightCharJSON({
      year: data.year,
      month: data.month,
      day: data.day,
      hour: data.hour,
      minute: 0, // default
      sect: 2, // default
      gender: data.gender,
    });
    return chartData;
  } catch (error) {
    console.error("Bazi calculation failed:", error);
    throw new Error("排盘过程中发生内部错误。");
  }
};