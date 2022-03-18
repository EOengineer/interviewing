import React, { useState, useEffect, useContext } from 'react'
import { TeamsContext } from '../../contexts/teams_context'

const TeamsIndex = () => {
  const teamsContext    = useContext(TeamsContext)
  const {teams, status} = teamsContext
  const teamsMap        = teams.map(team => <div key={team.name}>{team.name}</div>)

  return (
    <div>
      <h1>Teams Index</h1>
      {teamsMap}
    </div>
  )
}

export default TeamsIndex
