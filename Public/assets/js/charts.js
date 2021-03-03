var ctx = $("#chart1");

var data = {
    labels: ["January", "February", "March", "April", "May", "June", "July"],
    datasets: [
        {
            label: "Summary",
            fill: false,
            lineTension: 0.1,
            backgroundColor: "#1e87f0",
            borderColor: "#1e87f0",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "#1e87f0",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 3,
            pointHoverBackgroundColor: "#1e87f0",
            pointHoverBorderColor: "#1e87f0",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: [103265, 128259, 85290, 115923, 91238, 108295, 102295],
            spanGaps: false,
        }
    ]
};

var options = {
    responsive: true,
    maintainAspectRatio: false,
    legend: {
        display: false,
    },
    tooltips: {
        bodyFontColor: '#fff',
    },
    scales: {
            yAxes: [{
                gridLines: {
                    display: false,
                },
            }],
            xAxes: [{
                gridLines: {
                    display: false,
                }
            }]
        }
}

var myLineChart = new Chart(ctx, {
    type: 'line',
    data: data,
    options: options
});








var ctx = $("#chart2");

var data = {
    labels: ["January", "February", "March", "April", "May", "June", "July", "August", "September"],
    datasets: [
        {
            label: "Website traffic",
            fill: false,
            lineTension: 0.1,
            barThickness: 14,
            maxBarThickness: 16,
            backgroundColor: "#1e87f0",
            borderColor: "#1e87f0",
            borderCapStyle: 'butt',
            borderDash: [],
            borderDashOffset: 0.0,
            borderJoinStyle: 'miter',
            pointBorderColor: "#1e87f0",
            pointBackgroundColor: "#fff",
            pointBorderWidth: 1,
            pointHoverRadius: 3,
            pointHoverBackgroundColor: "#1e87f0",
            pointHoverBorderColor: "#1e87f0",
            pointHoverBorderWidth: 2,
            pointRadius: 1,
            pointHitRadius: 10,
            data: [103265, 128259, 85290, 115923, 91238, 108295, 102295, 256333, 254789],
            spanGaps: false,
        }
    ]
};

var options = {
    responsive: true,
    maintainAspectRatio: false,
    legend: {
        display: false,
    },
    tooltips: {
        bodyFontColor: '#fff',
    },
    scales: {
            yAxes: [{
                gridLines: {
                    display: false,
                },
            }],
            xAxes: [{
                gridLines: {
                    display: false,
                }
            }]
        }
}

var myLineChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: data,
    options: options
});
