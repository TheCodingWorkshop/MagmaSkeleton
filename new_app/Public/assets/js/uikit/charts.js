var ctx = $("#chart1");
var data = {
    labels: ["Pending", "Active", "Trash", "Lock"],
    datasets: [{
        label: "User Summary",
        fill: false,
        lineTension: 0.1,
        backgroundColor: "rgb(63, 126, 179)",
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
        data: [19.0, 2, 1, 2],
        spanGaps: false,
    }]
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

/*============================================================================*/

var ctx2 = $("#chart2");
var data = {
    labels: ["Emergency", "Alert", "Critical", "Error", "Warning", "Notice", "Info", "Debug"],
    datasets: [{
        label: "Logger",
        fill: false,
        lineTension: 0.1,
        barThickness: 14,
        maxBarThickness: 16,
        backgroundColor: "#333333",
        borderColor: "#333333",
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
        data: [5, 10, 0, 0, 0, 0, 0, 2],
        spanGaps: false,
    }]
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
var myHorizontalBarChart = new Chart(ctx2, {
    type: 'line',
    data: data,
    options: options
});

/*========================================================================*/

var ctx3 = $("#chart3");
var data = {
    labels: ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"],
    datasets: [{
        label: "Weekly",
        fill: false,
        lineTension: 0.1,
        barThickness: 14,
        maxBarThickness: 16,
        backgroundColor: ["rgb(188,219,251)", "rgb(188,219,251)", "rgb(188,219,251)", "rgb(188,219,251)", "rgb(188,219,251)", "rgb(188,219,251)", "rgb(188,219,251)"],
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
        data: [300, 58, 36, 55, 78, 152, 95],
        spanGaps: false,
    }]
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

var myBarChart = new Chart(ctx3, {
    type: 'bar',
    data: data,
    options: options
});