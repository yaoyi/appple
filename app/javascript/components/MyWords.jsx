import React from 'react';
import axios from 'axios';
import store from '../redux/store';
import {Provider} from 'react-redux';

export default class MyWords extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      myWords: []
    };
    this.handleChange = this.handleChange.bind(this)
    store.subscribe(this.handleChange)
  }

  handleChange(){
    let state = store.getState()
    this.setState({myWords: state.myWordsReducer})
  }

  componentDidMount() {
    axios.get('/my_words.json')
      .then(res => this.setState({myWords: res.data}))
      .catch(() => this.setState({myWords: []}));
  }

  deleteMyWord(id) {
    axios.delete('/my_words/' + id + '.json')
      .then(res => this.setState({myWords: res.data}))
      .catch(() => this.setState({myWords: []}));
  }

  render() {
    return (
      <Provider store={store}>
        <ul className="my-words">
          {this.state.myWords.map((myWord) => (
            <li className="my-word" key={myWord.id}>
              {myWord.text}
              <a onClick={(e) => this.deleteMyWord(myWord.id)}>x</a>
            </li>
          ))}
        </ul>
      </Provider>
    );
  }
}
