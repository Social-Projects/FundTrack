using System;
using System.Collections.Generic;
using Microsoft.AspNetCore.Mvc;
using FundTrack.BLL.Abstract;
using FundTrack.Infrastructure.ViewModel;
using System.Threading.Tasks;
using FundTrack.BLL.Concrete;
using System.Diagnostics;
using FundTrack.Infrastructure;

namespace FundTrack.WebUI.Controllers
{
    [Route("api/[controller]")]
    public class ReportsController : Controller
    {
        private readonly IReportService _service;

        public ReportsController(IReportService service)
        {
            _service = service;
        }

        [HttpGet("IncomeReport")]
        public IEnumerable<ReportIncomeViewModel> GetIncomeReports(int orgId, DateTime? dateFrom, DateTime? dateTo)
        {
            return _service.GetIncomeReports(orgId, dateFrom, dateTo);
        }

        [HttpGet("OutcomeReport")]
        public IEnumerable<ReportOutcomeViewModel> GetOutcomeReports(int orgId, DateTime? dateFrom, DateTime? dateTo)
        {
            return _service.GetOutcomeReports(orgId, dateFrom, dateTo);
        }

        [HttpGet("FinOpImages")]
        public IEnumerable<String> GetFinOpImages(int finOpId)
        {
            return _service.GetImagesById(finOpId);
        }

        [HttpGet("UsersDonationsPaginatedReport")]
        public async Task<IActionResult> UsersDonationsPaginatedReport(int? orgId, DateTime? dateFrom, DateTime? dateTo, int? pageIndex, int? pageSize, string filterValue)
        {
            if (isDataNotNull(dateFrom, dateTo, orgId, pageIndex, pageSize))
            {
                try
                {
                    var list = String.IsNullOrEmpty(filterValue)
                        ? await _service.GetUsersDonationsPaginatedReport(orgId.Value, dateFrom.Value, dateTo.Value, pageIndex.Value, pageSize.Value)
                        : await _service.GetFilteredUsersDonationsPaginatedReport(orgId.Value, dateFrom.Value, dateTo.Value, pageIndex.Value, pageSize.Value, filterValue);

                    return Ok(list);
                }
                catch (BusinessLogicException ex)
                {
                    return new BadRequestObjectResult(ex.Message);
                }
            }
            return new BadRequestObjectResult(ErrorMessages.InvalidData);
        }

        [HttpGet("CountOfUsersDonationsReport")]
        public async Task<IActionResult> CountOfUsersDonationsReport(int? orgId, DateTime? dateFrom, DateTime? dateTo, string filterValue)
        {
            if (isDataNotNull(dateFrom, dateTo, orgId))
            {
                try
                {
                    int count = String.IsNullOrEmpty(filterValue)
                       ? await _service.GetCountOfUsersDonationsReport(orgId.Value, dateFrom.Value, dateTo.Value)
                       : await _service.GetFilteredCountOfUsersDonationsReport(orgId.Value, dateFrom.Value, dateTo.Value, filterValue);

                    return Ok(count);
                }
                catch (BusinessLogicException ex)
                {
                    return new BadRequestObjectResult(ex.Message);
                }
            }
            return new BadRequestObjectResult(ErrorMessages.InvalidData);
        }

        [HttpGet("CountOfCommonUsersDonationsReport")]
        public async Task<IActionResult> CountOfCommonUsersDonationsReport(int? orgId, DateTime? dateFrom, DateTime? dateTo)
        {
            if (isDataNotNull(dateFrom, dateTo, orgId))
            {
                try
                {
                    int count = await _service.GetCountOfCommonUsersDonationsReport(orgId.Value, dateFrom.Value, dateTo.Value);
                    return Ok(count);
                }
                catch (BusinessLogicException ex)
                {
                    return new BadRequestObjectResult(ex.Message);
                }
            }
            return new BadRequestObjectResult(ErrorMessages.InvalidData);
        }

        [HttpGet("CommonUsersDonationsPaginatedReport")]
        public async Task<IActionResult> CommonUsersDonationsPaginatedReport(int? orgId, DateTime? dateFrom, DateTime? dateTo, int? pageIndex, int? pageSize)
        {
            if (isDataNotNull(dateFrom, dateTo, orgId, pageIndex, pageSize))
            {
                try
                {
                    var list = await _service.GetCommonUsersDonationsPaginatedReport(orgId.Value, dateFrom.Value, dateTo.Value, pageIndex.Value, pageSize.Value);
                    return Ok(list);
                }
                catch (BusinessLogicException ex)
                {
                    return new BadRequestObjectResult(ex.Message);
                }
            }
            return new BadRequestObjectResult(ErrorMessages.InvalidData);
        }

        private bool isDataNotNull(DateTime? dateFrom, DateTime? dateTo, params int?[] parametrs)
        {
            var res = (dateTo.HasValue && dateTo <= DateTime.Now.Date) &&
                (dateFrom.HasValue && dateFrom.Value <= dateTo);

            foreach (var item in parametrs)
            {
                res = res & item.HasValue;
            }

            return res;
        }
    }
}