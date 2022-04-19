'use strict';

const e = React.createElement;

class LikeButton extends React.Component {
    constructor(props) {
        super(props);
        this.state = {
            error: null,
            isLoaded: false,
            data: []
        };
    }

    componentDidMount() {
        fetch('http://localhost/api/user/index')
            .then(res => res.json())
            .then(
                (result) => {
                    console.log(result)
                    this.setState({
                        isLoaded: true,
                        data: result
                    });
                },
                (error) => {
                    this.setState({
                        isLoaded: true,
                        error
                    });
                }
            )
    }

    render() {
        const { error, isLoaded, data } = this.state;
        if (error) {
            return <div>Error: {error.message}</div>;
        } else if(!isLoaded) {
            return <div>Loading...</div>;
        } else {
            return (
                <section className="uk-margin">
                    <nav aria-label="Pagination" className="uk-navbar">
                        <div className="uk-navbar-left">
                            <ul className="uk-iconnav">
                                <li>
                                    <button type="button" className="uk-button uk-button-default uk-button-small">
                                        <input type="checkbox" className="uk-checkbox" name="selectAll" id="selectAllDomainList"/> Select All
                                    </button>
                                </li>
                                <li><a className="ion-28" href="/admin/user/new" uk-tooltip="Add new">
                                    <ion-icon name="add-outline"></ion-icon>
                                </a></li>
                                <li className="bulk-trash"><a className="ion-28" href="#" uk-tooltip="Bulk Trash">
                                    <ion-icon name="trash-outline"></ion-icon>
                                </a></li>
                                <li className="bulk-copy"><a className="shake ion-28" href="#" uk-tooltip="Bulk Copy">
                                    <ion-icon name="copy-outline"></ion-icon>
                                </a></li>
                                <li><a href="#"><span uk-icon="icon: bag"></span> (2)</a></li>
                                <li className="uk-inline">
                                    <input className="uk-search-input uk-form-blank uk-border-bottom uk-search-large" type="search" placeholder="Search..."/>
                                </li>
                                <li><a className="ion-28" href="#" uk-tooltip="Filter">
                                    <ion-icon name="filter-outline"></ion-icon>
                                </a></li>
                            </ul>
                        </div>
                        <div className="uk-navbar-right">
                            <small>{data.current_page} to {data.total_pages} of {data.total_records}</small>
                            <ul className="uk-pagination">
                                <li><a href=""><span></span></a></li>
                                <li><a href=""><span></span></a></li>
                            </ul>
                            {/*<div dangerouslySetInnerHTML={{ __html: data.table }} />*/}
                        </div>
                    </nav>
                </section>
            );

        }
    }
}

const domContainer = document.querySelector('#uikit_simple_pagination_reactjs');
ReactDOM.render(e(LikeButton), domContainer);