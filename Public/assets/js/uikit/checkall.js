$('#selectAllDomainList').click (function () {
    const checkedStatus = this.checked;
    $('#datatable tbody tr').find('td:first :checkbox').each(function () {
        $(this).prop('checked', checkedStatus);
    });
});
