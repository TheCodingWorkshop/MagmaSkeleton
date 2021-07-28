'use strict';

const e = React.createElement;

class ReactDatatable extends React.Component {
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
            <div dangerouslySetInnerHTML={{ __html: data.table }} />
            );

        }
    }
}

const domContainer = document.querySelector('#react_datatable');
ReactDOM.render(e(ReactDatatable), domContainer);