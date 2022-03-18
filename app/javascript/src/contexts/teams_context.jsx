import React, { createContext, useState, useEffect } from 'react'

export const TeamsContext = React.createContext()

export const TeamsDataProvider = (props) => {
  const [state, setState] = useState({ teams: [], status: 'LOADING' })

  useEffect(() => {
    setState({ teams: state.teams, status: 'LOADING '});

    const fetchTeams = async () => {
      const response = await fetch('/api/v1/teams')

      if (response.ok) {
        const teams = await response.json()
        setState({teams: teams, status: 'LOADED'})
      } else {
        setState({teams: state.teams, status: 'ERROR' })
      }
    }
    fetchTeams()
  }, [])

  return (
    <TeamsContext.Provider value={state}>
      {props.children}
    </TeamsContext.Provider>
  )
}
