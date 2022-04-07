import React, { createContext, useState, useEffect } from 'react'

export const CurrentUserContext = React.createContext()

export const CurrentUserDataProvider = (props) => {
  const [state, setState] = useState({ user: null, status: 'LOADING' })

  const loadCurrentUser = () => {
    let currentUserNode = document.getElementById('root').dataset.current_user
    if (currentUserNode)
      return JSON.parse(currentUserNode)
  }

  useEffect(() => {
    setState({user: loadCurrentUser(), status: 'LOADED'})
  }, [])

  return (
    <CurrentUserContext.Provider value={state}>
      {props.children}
    </CurrentUserContext.Provider>
  )
}
