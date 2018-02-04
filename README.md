# SportsEngine Take Home Assignment
A take home assignment from the crew at SportsEngine.

## Objective
Implement an API endpoint in Rails (or any sufficient tech stack) that will generate games for a “pool play” round of a tournament.
Once completed, send the project to our engineers.
If you have any questions, feel free to ask.

## Basic Requirements
1. Nothing needs to be persisted.
2. The endpoint needs to accept the following parameters:
    * Number of pools.
    * Number of teams.

    * Number of rounds.

3. Use snake seeding to assign teams to pools.

4. The response should be the list of pools along with
their generated games.

## Additional Information

* Include what you would do if the code were to be deployed to a production environment.
* Include what you would do if you had to maintain the software long term.
* The pools should be objects, and should have a name property in the pattern of “Pool
A”, “Pool B”, etc. The generated games should be attached as an array property on each
pool.
* Each game should have a unique id, and two teams. These teams can be simple strings,
with the pattern of “Team #1”, “Team #2”, etc., but each team should have one game per round against every other team in the pool.

* Apple autocomplete messed up the repo name before I noticed.

## Bonus Requirements
1. Set up a basic form UI that will take in the parameters and display a rendered form of the generated games.
2. Add a parameter that will populate the pools using a sequential seeding method.