do_after = false
task_line_chart = null
@charts = () ->
  start_date = $('#start_date').datepicker('getFormattedDate')
  end_date = $('#end_date').datepicker('getFormattedDate')
  # $.ajax(url: "stats.json?statuses&task_processing_chart&start_date=#{start_date}&end_date=#{end_date}",dataType: "json").done (data) ->
  #   if !jQuery.isEmptyObject(data['ERRORS'])
  #     for msg in data['ERRORS']
  #       notify = $.notify({
  #         # options
  #         message: msg
  #         title: 'INPUT ERROR:'
  #         icon: 'fa fa-info-circle'
  #       },{
  #         # settings
  #         type: 'warning'
  #       });
  #     return
  #   statuses = data['statuses']
  #   $('#ERROR_status').text(statuses['ERROR'] ?= 0)
  #   if (statuses['ERROR'] ?= 0) == 0
  #     $('#ERROR_status').parent().parent().parent().parent().removeClass('panel-red')
  #     $('#ERROR_status').parent().parent().parent().parent().addClass('panel-green')
  #   else
  #     $('#ERROR_status').parent().parent().parent().parent().removeClass('panel-green')
  #     $('#ERROR_status').parent().parent().parent().parent().addClass('panel-red')
  #   $('#PENDING_status').text(statuses['PENDING'] ?= 0)
  #   $('#WAITING_status').text(statuses['WAITING'] ?= 0)
  #   $('#COMPLETED_status').text(statuses['COMPLETED'] ?= 0)
  #   if(task_line_chart != null)
  #     task_line_chart.destroy()
  #   task_processing_chart = data['task_processing_chart']
  #   ctx = $('#task_line_chart').get(0).getContext('2d')
  #   task_line_chart = new Chart(ctx, {
  #       type: 'line',
  #       data: {
  #         labels: task_processing_chart['LABELS'],
  #         datasets: [
  #           {
  #             label: 'Processed Tasks'
  #             borderColor: "rgb(92, 184, 92)"
  #             backgroundColor: "rgb(150, 212, 150)"
  #             fill: false
  #             # lineTension: .3
  #             cubicInterpolationMode: 'monotone'
  #             data: task_processing_chart['PROCESSED']
  #           },
  #           {
  #             label: 'Errors'
  #             backgroundColor: "rgb(227, 141, 137)"
  #             borderColor: "rgb(217, 83, 79)"
  #             fill: false
  #             cubicInterpolationMode: 'monotone'
  #             data: task_processing_chart['TASKERRORS']
  #           }
  #         ]
  #       },
  #       options: {
  #         legend: {
  #           position: 'bottom'
  #         }
  #         scales: {
  #           xAxes: [{
  #             time: {
  #               unit: 'day'
  #             }
  #             scaleLabel: {
  #               display: true,
  #               labelString: 'Date'
  #             }
  #           }]
  #           yAxes: [{
  #             scaleLabel: {
  #               display: false
  #
  #             }
  #             ticks: {
  #               beginAtZero: true
  #               callback: (value) ->
  #                 if value % 1 == 0
  #                   return value
  #                 return
  #             }
	# 				}]
  #         }
  #       }
  #   });
$(document).ready ->
  if ($(".home.index").length != 0)
    $("#end_date").datepicker();
    $("#start_date").datepicker();
    $('#start_date').on "changeDate", ->
      charts();
    $('#end_date').on "changeDate", ->
      charts();
    charts();
