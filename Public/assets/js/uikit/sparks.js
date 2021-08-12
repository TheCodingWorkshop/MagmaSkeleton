$(document).ready(function() {
    $("#sparkline").sparkline([100, 155, 58, 68, -45], {
        type: 'bar',
        height: '30%',
        barWidth: '20%',
        barColor: "rgb(30, 135, 240)",
        negBarColor: "rgb(32, 42,47)",
        zeroColor: 'green'
    });
});
