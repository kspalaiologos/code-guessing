#include <iostream>
#include <fstream>
#include <vector>
#include <string>

int get_participant(const std::vector<std::string> & table, const std::string & name) {
    for(int i = 0; i < table.size(); i++)
        if(table[i] == name)
            return i;
    return -1;
}

int main() {
    std::vector<std::string> participants;
    std::ifstream participants_file("submissions/participants.txt");
    while(!participants_file.eof() && participants_file.good()) {
        std::string name;
        participants_file >> name;
        if(name.length() == 0)
            break;
        participants.push_back(name);
        std::cerr << "Registering participant: " << name << std::endl;
    }
    participants_file.close();

    std::vector<int> mappings(participants.size());
    std::ifstream mappings_file("submissions/shuffled.txt");
    for(int i = 0; i < participants.size(); i++) {
        int to, from;
        mappings_file >> to >> from;
        if(mappings_file.bad())
            // some day, love will find you
            break; // those chains that bind you
        mappings[from - 1] = to - 1;
        std::cerr << "Registering mapping: " << to - 1 << " => " << from - 1 << std::endl;
    }
    mappings_file.close();

    std::vector<std::string> answers(participants.size());
    std::ifstream answers_file("submissions/answers.txt");
    for(int i = 0; i < participants.size(); i++) {
        std::string name, sub_number;
        int ord;
        answers_file >> name >> sub_number;
        ord = std::stoi(sub_number);
        std::cerr << "Registering answer: #" << mappings[ord - 1] << "(#" << ord - 1 << ")" << ": " << name << std::endl;
        answers[mappings[ord - 1]] = name;
    }
    answers_file.close();

    std::vector<std::vector<std::string>> guesses;
    for(const auto & participant : participants) {
        std::cerr << participant << "'s guesses:" << std::endl;
        std::vector<std::string> guess(participants.size());
        for(auto & g : guess) {
            std::getline(std::cin, g);
            std::cerr << g << std::endl;
        }
        guesses.push_back(guess);
    }

    std::vector<std::vector<bool>> is_valid;
    for(const auto & persons_guess : guesses) {
        std::vector<bool> personal_valid(persons_guess.size());
        for(int i = 0; i < persons_guess.size(); i++)
            if(personal_valid[i] = persons_guess[i] == answers[i])
                std::cerr << "Guessed " << persons_guess[i] << "!" << std::endl;
            else
                std::cerr << "Guessed " << persons_guess[i] << ", expected " << answers[i] << std::endl;
        std::cerr << std::endl;
        is_valid.push_back(personal_valid);
    }

    for(int i = 0; i < participants.size(); i++)
        is_valid[i][i] = false;
    
    std::vector<int> scores;
    for(const auto & v : is_valid) {
        int total = 0;
        for(const auto & x : v)
            total += x ? 1 : 0;
        scores.push_back(total);
    }

    for(int i = 0; i < participants.size(); i++)
        std::cerr << participants[i] << ": " << scores[i] << std::endl;
    std::cerr << std::endl;

    for(int j = 0; j < guesses.size(); j++)
        for(int i = 0; i < guesses[j].size(); i++)
            if(guesses[j][i] == answers[i] && i != j)
                scores[get_participant(participants, answers[i])]--;

    for(int i = 0; i < participants.size(); i++)
        std::cout << participants[i] << ": " << scores[i] << std::endl;
}
