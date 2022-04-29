import React, { useState, useEffect, useContext } from 'react'
import { TeamsContext } from '../../contexts/teams'

const TeamsIndex = () => {
  const teamsContext    = useContext(TeamsContext)
  const {teams, status} = teamsContext

  const teamsMap = teams.map(team => {
    return (
      <div className='p-5 m-1 w-25 border text-center' key={team.name}>{team.name}</div>
    )
  })

  return (
    <div className="container-fluid">
      <h1>Teams Index</h1>
      <div className="d-flex flex-wrap p-2 justify-content-around bd-highlight">
        {teamsMap}
      </div>
    </div>
  )
}

export default TeamsIndex
