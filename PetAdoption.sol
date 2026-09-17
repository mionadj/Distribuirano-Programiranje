// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PetAdoption {

    // Podaci o ljubimcu
    struct Pet {
        uint id;
        string name;
        string species;
        uint age;
        bool adopted;
        address adopter;
    }

    // Adresa vlasnika ugovora - azil
    address public owner;

    // Lista svih ljubimaca
    Pet[] public pets;

    // Konstruktor se izvršava samo jednom, prilikom kreiranja ugovora
    constructor() {
        owner = msg.sender;
    }

    // Dodavanje novog ljubimca
    function addPet( string memory _name, string memory _species, uint _age) public {

        require(msg.sender == owner, "Only the shelter can add pets");

        Pet memory newPet = Pet({
            id: pets.length,
            name: _name,
            species: _species,
            age: _age,
            adopted: false,
            adopter: address(0)
        });

        pets.push(newPet);
    }

    // Usvajanje ljubimca
    function adoptPet(uint _petId) public {

        require(_petId < pets.length, "Pet does not exist");

        require(
            pets[_petId].adopted == false,
            "Pet is already adopted"
        );

        pets[_petId].adopted = true;
        pets[_petId].adopter = msg.sender;
    }

    // Pregled podataka o ljubimcu
    function getPet(uint _petId)
        public
        view
        returns (
            uint,
            string memory,
            string memory,
            uint,
            bool,
            address
        )
    {
        require(_petId < pets.length, "Pet does not exist");

        Pet memory pet = pets[_petId];

        return (
            pet.id,
            pet.name,
            pet.species,
            pet.age,
            pet.adopted,
            pet.adopter
        );
    }

    // Broj registrovanih ljubimaca
    function getPetsCount() public view returns (uint) {
        return pets.length;
    }
}
