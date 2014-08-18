# include <iostream>

using namespace std;

class Solution {
public:
    string getPermutation(int n, int k) {
        int div = 1;
        for (int i = 2; i < n; ++ i){
            div *= i;
        }
        bool available[n];
        for (int i = 0; i < n; ++ i)
            available[i] = true;
            
        string result("");
        n --;
        k --;
        while(k){
            int num = k / div;
            k = k - num * div
            while(!available[num])
                num ++;
                
            result.push_back(num + '1');
            available[num] = false;
            div /= n--;
            
        }
        return result;
    }
};

int main(){
    Solution sl;
    cout << sl.getPermutation(3, 6) << endl;
    return 0;
}