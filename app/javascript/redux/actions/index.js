import axios from 'axios';
import {LOAD_MY_WORDS_SUCCESS} from './actionTypes';

export function loadMyWords() {
  return function(dispatch) {
    return axios.get('/my_words.json')
      .then(res => { dispatch(loadMyWordsSuccess(res.data))})
      .catch(error => { throw(error); });
  }
}

export function loadMyWordsSuccess(myWords) {
  return {type: LOAD_MY_WORDS_SUCCESS, myWords};
}
