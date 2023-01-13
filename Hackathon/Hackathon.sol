// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

contract Hackathon {
    struct Project {
        string title;
        uint[] ratings;
    }
    
    Project[] projects;

    //Finds the winner based average score of all ratings
    function findWinner() external view returns(Project memory){
      uint topAverage = 0;
      Project memory winner;

      for (uint i = 0; i < projects.length; i++) {
          uint sum;
        for (uint j; j < projects[i].ratings.length; j++) {
          sum += projects[i].ratings[j];
        }
        uint avg = sum / projects[i].ratings.length;
        
        if (topAverage < avg) {
          topAverage = avg;
          winner = projects[i];
        } 
      }
      return winner;
    }

    function newProject(string calldata _title) external {
        // creates a new project with a title and an empty ratings array
        projects.push(Project(_title, new uint[](0)));
    }

    function rate(uint _idx, uint _rating) external {
        // rates a project by its index
        projects[_idx].ratings.push(_rating);
    }
}
