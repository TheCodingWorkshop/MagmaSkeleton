(function($) {
    LavaCMS = {

        getID: function(docmentID) {
            return document.getElementById(docmentID);
        },
        multiArray: function(data, c = true) {

            var output = [];
            for (var i in data) {
                var outerData = data[i];
                for (var j in outerData) {
                    var innerData = outerData[j];
                    if (c) {
                        output.push(innerData.count)
                    } else {
                        output.push(innerData);
                    }

                }
            }
            return output;
        },
        singleArray: function(data) {
            var output = [];
            for (var i in data) {
                output.push(data[i])
            }
            return output
        },
        /**
         * 
         * @param {string} endpoint 
         * @param {string} method *GET, POST, PUT, DELETE, etc.
         * @param {string} mode no-cors, *cors, same-origin
         * @param {string} cache *default, no-cache, reload, force-cache, only-if-cached
         * @param {string} credentials include, *same-origin, omit
         * @param {object} headers 'Content-Type': 'application/x-www-form-urlencoded',
         * @param {object} data body data type must match "Content-Type" header
         */
        fetch: async function(
            endpoint = '',
            method = 'POST',
            mode = 'cors',
            cache = 'no-cache',
            credentials = 'same-origin',
            headers = { 'Content-Type': 'application-json' },
            data = {}) {
            const response = await fetch(endpoint, {
                method: method,
                mode: mode,
                cache: cache,
                credentials: credentials,
                header: headers,
                redirect: 'follow',
                referrerPolicy: 'no-referrer',
                body: JSON.stringify(data)
            });
            return await response.json();
        },
        createNode: function(element) {
            return document.createElement(element);
        },
        append: function(parent, el) {
            return parent.appendChild(el);
        },
        chartDatasets: function(data, colors, label) {
            var dataSets = [{
                label: label,
                data: data,
                backgroundColor: colors,
                borderColor: colors,
                borderWidth: 1,
                borderCapStyle: 'butt',
                borderDash: [],
                borderDashOffset: 0.0,
                borderJoinStyle: 'miter',
                pointBorderColor: colors[0],
                pointBackgroundColor: "#fff",
                pointBorderWidth: 1,
                pointHoverRadius: 3,
                pointHoverBackgroundColor: colors[0],
                pointHoverBorderColor: colors[0],
                pointHoverBorderWidth: 2,
                pointRadius: 1,
                pointHitRadius: 10,
                spanGaps: false,

            }];

            return dataSets;
        },
        chartOptions: function() {
            var options = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: true,
                },
                tooltips: {
                    bodyFontColor: '#fff',
                },

                scales: {
                    yAxes: [{
                        ticks: {
                            beginAtZero: true
                        }
                    }]
                }


            };
            return options;
        },
        lineOptions: function() {
            var options = {
                responsive: true,
                maintainAspectRatio: false,
                legend: {
                    display: true,
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

            };
            return options;
        },

        popoutHTML: function(el) {
            var html = `
                <div class="uk-card uk-background-blend-screen uk-padding-remove uk-margin-remove">
                <div class="uk-card-header uk-padding-remove">
                    <div class="uk-grid-small uk-flex-middle" uk-grid>
                        <div class="uk-width-auto">
                            <span uk-icon="icon: ${el.icon}; ratio: 1.5"></span>
                        </div>
                        <div class="uk-width-expand">
                            <h3 class="uk-button uk-button-text uk-margin-remove-bottom">${el.title}!</h3>
                            <p class="uk-text-meta uk-margin-remove-top">${el.detail}
                            <small class="uk-text-meta uk-display-block"><time datetime="${el.created_at}">${el.created_at}</time></small>
                            </p>
                        </div>
                    </div>
                </div>
                <div class="uk-card-footer">
                <hr>
                </div>
            </div>

            `
            return html;
        },
        notificationsCounter: function() {
            const element = LavaCMS.getID('notifications-counter');
            LavaCMS.fetch('/admin/dashboard/count-notifications')
                .then((noti_counter) => {
                    element.innerHTML = noti_counter;
                })
                .catch((error) => {

                })
        },
        notifications: function() {
            const element = LavaCMS.getID('popout-notifications');
            LavaCMS.fetch('/admin/dashboard/notifications')
                .then((response) => {
                    const keys = Object.values(response);
                    for (const el of keys) {
                        element.innerHTML += LavaCMS.popoutHTML(el);
                    }
                })
                .catch((error) => {

                })
        },
        activities: function() {
            const element = LavaCMS.getID('popout-activities');
            LavaCMS.fetch('/admin/dashboard/recent-activity-ajax')
                .then((response) => {
                    const keys = Object.values(response);
                    for (const el of keys) {
                        element.innerHTML += LavaCMS.popoutHTML(el)
                    }
                })
                .catch((error) => {

                })
        },
        preview_image: function() {
            var total_file = LavaCMS.getID("upload_file").files.length;
            for (var i = 0; i < total_file; i++) {
                $('#image_preview').append("<img class='uk-border-rounded' data-src='" + URL.createObjectURL(event.target.files[i]) + "' uk-img><br>");
            }
        },
        barChart: function() {
            $(function() {
                $.post('/charts/user-flow-chart/daily-user', function(rawData) {
                    var _data = []; // data count
                    var _labels = []; // charts labels
                    var _colors = []; // charts colors backgroundColors and borderColor etc..

                    _data = LavaCMS.multiArray(rawData.data);
                    _labels = LavaCMS.singleArray(rawData.labels);
                    _colors = LavaCMS.singleArray(rawData.backgroundColors);

                    var _chartDatasets = LavaCMS.chartDatasets(_data, _colors, rawData.label);
                    var _chartOptions = LavaCMS.chartOptions();

                    var ctx1 = LavaCMS.getID(rawData.chartID).getContext('2d');
                    var barChart = new Chart(ctx1, {
                        type: rawData.chartType,
                        data: {
                            labels: _labels,
                            datasets: _chartDatasets
                        },
                        options: _chartOptions
                    })
                })
            });
        },
        horizontalBarChart: function() {
            $(function() {
                $.post('/charts/user-chart/browser', function(rawData) {
                    var _data = []; // data count
                    var _labels = []; // charts labels
                    var _colors = []; // charts colors backgroundColors and borderColor etc..

                    _data = LavaCMS.singleArray(rawData.data);
                    _labels = LavaCMS.singleArray(rawData.labels);
                    _colors = LavaCMS.singleArray(rawData.backgroundColors);

                    var _chartDatasets = LavaCMS.chartDatasets(_data, _colors, rawData.label);
                    var _chartOptions = LavaCMS.chartOptions();

                    var ctx2 = LavaCMS.getID('browser').getContext('2d');
                    var horizontalBarChart = new Chart(ctx2, {
                        type: 'horizontalBar',
                        data: {
                            labels: _labels,
                            datasets: _chartDatasets
                        },
                        options: _chartOptions
                    })
                })
            });
        },
        lineChart: function() {
            $(function() {
                $.post('/charts/count/charts-data-count', function(rawData) {
                    var _data = []; // data count
                    var _labels = []; // charts labels
                    var _colors = []; // charts colors backgroundColors and borderColor etc..

                    _data = LavaCMS.singleArray(rawData.data);
                    _labels = LavaCMS.singleArray(rawData.labels);
                    _colors = LavaCMS.singleArray(rawData.backgroundColors);

                    var _chartDatasets = LavaCMS.chartDatasets(_data, _colors, rawData.label);
                    var _chartOptions = LavaCMS.lineOptions();

                    var ctx3 = LavaCMS.getID('browser-line-chart').getContext('2d');
                    var horizontalBarChart = new Chart(ctx3, {
                        type: 'line',
                        data: {
                            labels: _labels,
                            datasets: _chartDatasets
                        },
                        options: _chartOptions
                    })
                })
            });

        },
        popoutSearch: function() {
            $(function() {

            })
        },
        ajaxContentLoader: function(containerID, urlPath) {
            $(function() {
                window.addEventListener('load', (event) => {
                    $("#" + containerID).load(urlPath, function(responseTxt, statusTxt, xhr) {
                        if (statusTxt == 'success') {
                            //console.log(responseTxt)
                        }
                        if (statusTxt == 'error') {
                            //console.log("Error: " + xhr.status + ": " + xhr.statusText);
                        }
                    })
                })
            })
        },
        CheckUncheckAll: function(chkAll) {
            $(function() {
                //Fetch all rows of the Table.
                var rows = LavaCMS.getID("datatable").rows;
                //Execute loop on all rows excluding the Header row.
                var isCheck = true;
                for (var i = 1; i < rows.length; i++) {
                    isCheck = rows[i].getElementsByTagName("INPUT")[0].checked = chkAll.checked;
                }
                LavaCMS.bulkActionIcon(isCheck);

            })
        },
        CheckUncheckHeader: function() {
            $(function() {
                //Determine the reference CheckBox in Header row.
                var chkAll = LavaCMS.getID("chkAll");
                //By default set to Checked.
                chkAll.checked = true;
                //Fetch all rows of the Table.
                var rows = LavaCMS.getID("datatable").rows;

                //Execute loop on all rows excluding the Header row.
                for (var i = 1; i < rows.length; i++) {
                    if (!rows[i].getElementsByTagName("INPUT")[0].checked) {
                        chkAll.checked = false;
                        var isCheck = chkAll;
                        break;
                    }
                }
                /* if (chkAll) {

                     button.classList.add("uk-text-danger");
                     button.classList.add("uk-animation-shake");
                     form.classList.remove("uk-disabled");

                 } else {
                     button.classList.remove("uk-text-danger");
                     form.classList.add("uk-disabled");
                 }*/


            })
        },
        bulkActionIcon: function(isCheck) {
            $(function() {
                var showButton = LavaCMS.getID('bulk-table-action');
                var showButtonText = LavaCMS.getID('bulk-table-action-text');
                if (isCheck) {
                    showButton.classList.remove('uk-disabled');
                    showButton.classList.add('uk-text-teal');
                    showButton.classList.add('uk-animation-shake');

                    LavaCMS.bulkAction(isCheck);

                } else {
                    showButton.classList.add('uk-disabled');
                    showButton.classList.remove('uk-text-teal');
                    showButton.classList.remove('uk-animation-shake');
                }

            })
        },
        bulkAction: function(isCheck) {
            $(function() {
                $('.bulk-action-button').click(function(e) {
                    e.preventDefault();
                    if (confirm("Are you sure you want to delete these?")) {
                        var ID = [];
                        $(':checkbox:checked').each(function(i) {
                            ID[i] = $(this).val();
                        });
                        if (ID.length === 0) {
                            alert("Please select atleast one checkbox");
                        } else {
                            $.ajax({
                                url: '/admin/post/bulk-delete',
                                method: 'POST',
                                data: { id: ID },
                                success: function() {
                                    for (var i = 0; i < ID.length; i++) {
                                        alert(ID[i]);
                                        $('tr#' + ID[i] + '').css('background-color', '#ccc');
                                        $('tr#' + ID[i] + '').fadeOut('slow');
                                    }
                                }
                            })
                        }
                    } else {
                        return false;
                    }
                })
            })
        },
        fetchCategories: function() {
            $(function() {
                let categoryUL = document.getElementById("post-categories");
                LavaCMS.fetch('/admin/post/fetch-categories')
                    .then((data) => {
                        return data.map(function(category) {
                            let li = LavaCMS.createNode("li")
                            let label = LavaCMS.createNode("label");
                            label.innerHTML = `<input type="checkbox" name="cat_name[]" value="${category.id}" class="uk-checkbox"/> ${category.cat_name}`;
                            LavaCMS.append(li, label);
                            LavaCMS.append(categoryUL, li);
                        })
                    }).catch((error) => {});

            })
        },
        fetchTags: function() {
            $(function() {
                let tagSelect = document.getElementById("post-tags");
                LavaCMS.fetch('http://localhost/admin/post/fetch-tags')
                    .then((tagData) => {
                        return tagData.map(function(tag) {
                            tagSelect.innerHTML += `<option value="${tag.id}">${tag.tag_name}</option>`;
                        })
                    }).catch((error) => {});


            })
        },
        clearAlert: function() {
            $(function() {
                setTimeout(function() {
                    $('.fade-alert').slideUp("slow");
                }, 2000);
            })
        },
        showBulkAction: function() {}

    }
    $(document).ready(function() {
        //setInterval(function() {
        //LavaCMS.notificationsCounter();
        //}, 3000)
        //LavaCMS.showBulkAction();
        //LavaCMS.activities();
        ///LavaCMS.fetchCategories();
        //LavaCMS.fetchTags();
        //LavaCMS.clearAlert();
    });
    window.onload = function() {
        //LavaCMS.barChart();
        //LavaCMS.horizontalBarChart();
        //LavaCMS.lineChart();
        LavaCMS.CheckUncheckAll(this);
    }
})(jQuery);