import {combineReducers} from 'redux';
import {LOAD_MY_WORDS_SUCCESS} from '../actions/actionTypes';

function myWordsReducer(state=[], action) {
  switch (action.type) {
  case LOAD_MY_WORDS_SUCCESS:
    return action.myWords;
  default:
    return state;
  }
}

const rootReducer = combineReducers({myWordsReducer});

export default rootReducer;
