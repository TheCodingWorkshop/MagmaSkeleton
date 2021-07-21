function selects() {
    const ele = document.getElementsByName('id[]');
    const links = document.getElementsByClassName('bulk-action-links');
    for (let i=0; i < ele.length; i++) {
        if (ele[i].type == 'checkbox') {
            ele[i].checked = true;
        }
    }
}
function deSelect(){
    const ele = document.getElementsByName('id[]');
    const links = document.getElementsByClassName('bulk-action-links');
    for(let i=0; i<ele.length; i++){
        if(ele[i].type=='checkbox')
            ele[i].checked=false;
            //links.className.add('uk-disabled');

    }
}

class Framework {

    constructor(document) {
        this.id = document.getElementById()
    }

}

