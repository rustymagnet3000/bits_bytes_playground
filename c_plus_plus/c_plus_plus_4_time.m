#include <iostream>
#include <ctime>

using namespace std;

class YDTime {
    private:
        double seconds;
        time_t start;
    public:
        YDTime(void);
        ~YDTime(void);
};

inline YDTime::YDTime(void)
{
    time(&start); 
    seconds = 0.0;
    cout << "[+] " << ctime(&start);
}

inline YDTime::~YDTime(void)
{
    seconds = difftime(time(NULL), start);
    cout << "[+] Time to complete: " << seconds << " seconds \n";
}

int main() {
    
    class YDTime mytime;
    return 0;
}
