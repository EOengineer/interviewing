// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'

import { TeamsContext, TeamsDataProvider } from '../src/contexts/teams_context'

import TeamsIndex from '../src/views/teams/index'

const App = () => (
  <TeamsIndex />
)

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(
    <TeamsDataProvider>
      <App />
    </TeamsDataProvider>,
    document.body.appendChild(document.createElement('div')),
  )
})
