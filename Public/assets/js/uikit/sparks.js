$(document).ready(function() {
    // $("#sparkline").sparkline([100, 155, 58, 68, -45], {
    //     type: 'bar',
    //     height: '30%',
    //     barWidth: '20%',
    //     barColor: "rgb(30, 135, 240)",
    //     negBarColor: "rgb(32, 42,47)",
    //     zeroColor: 'green'
    // });
    $("#active_now_pie").sparkline([1, 1, 2], {
        type: 'bar',
        height: '60',
        barWidth: '10',
        barColor: '#222222'
    });

    $("#todays_visit_bar").sparkline([5, 6, 7, 2, 0, -4, -2, 4], {
        type: 'bar',
        height: '60',
        barWidth: '10',
        barColor: '#222222'
    });
    $("#bounce_rate").sparkline([5, 6, 7, 9, 9, 5, 3, 2, 2, 4, 6, 7], {
        type: 'line',
        width: '70',
        height: '59',
        lineColor: '#ff0000',
        fillColor: '#222222'
    });

});