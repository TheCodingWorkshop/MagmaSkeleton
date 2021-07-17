function checkUncheckAll() {
    var rows = document.getElementsByName('id[]'); // *Columns name attribute 
    var isCheck = false; // flag defaults to false 
    rows.forEach((cb) => {
        if (cb.type === 'checkbox') {
            if (cb.checked === false) {
                isCheck = true
                cb.checked = true;
            } else {
                if (cb.checked === true) {
                    isCheck = false;
                    cb.checked = false;
                }
            }
        }
    })
    whenCheck(isCheck)

}

function whenCheck(isCheck) {
    var toggle = document.getElementById("js-selector-container");
    if (isCheck === true) {
        toggle.innerHTML = `
            <div class="uk-background-muted uk-margin-remove uk-padding-small">
                <button uk-icon="icon: trash" class="uk-button uk-button-small uk-button-default" type="submit" name="bulk_delete"></button>
            <button uk-icon="icon: file-edit" class="uk-button uk-button-small uk-button-default" type="submit" name="bulk_delete"></button>							

            </div>
        `;
    } else {
        toggle.innerHTML = "";
    }
}