import React from 'react';
import axios from 'axios';
import Autocomplete from 'react-autocomplete';
import store from '../redux/store';
import {Provider} from 'react-redux';
import {loadMyWords} from '../redux/actions';

export default class Search extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      query: '',
      items: [],
      my_words: []
    };
    this.handleChange = this.handleChange.bind(this);
    this.handleSelect = this.handleSelect.bind(this);
  }

  handleChange(event, query) {
    this.setState({query: query});
    if(query.length > 0) {
      axios.get('/search.json', {params: {query: query}})
        .then(res => this.setState({items: res.data.suggestions}))
        .catch(error => { throw(error); });
    }
  }

  handleSelect(value, item) {
    this.setState({query: ''});
    axios.post('/save.json', {id: item.data})
      .then(res => store.dispatch(loadMyWords()))
      .catch(error => { throw(error); });
  }

  render() {
    return (
      <Provider store={store}>
        <Autocomplete
          value={this.state.query}
          inputProps={{id: 'search'}}
          items={this.state.items}
          getItemValue={(item) => item.value}
          onChange={this.handleChange}
          onSelect={this.handleSelect}
          renderMenu={children => (
            <div className="menu">
              {children}
            </div>
          )}
          renderItem={(item, isHighlighted) => (
            <div
              className={`item ${isHighlighted ? 'item-highlighted' : ''}`}
              key={item.data}
            >{item.value}</div>
          )}
        ></Autocomplete>
      </Provider>
    );
  }
}
