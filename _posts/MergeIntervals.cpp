# include <iostream>
# include <algorithm>
# include <vector>

using namespace std;


struct Interval {
    int start;
    int end;
    Interval() : start(0), end(0) {}
    Interval(int s, int e) : start(s), end(e) {}
};
     

bool myfunc(Interval in1, Interval in2){
    if (in1.start < in2.start)
        return true;
    else if(in1.start == in2.start && in1.end < in2.end)
        return true;
    return false;
} 
    
class Solution {
public:
    vector<Interval> merge(vector<Interval> &intervals) {
        sort(intervals.begin(), intervals.end(), myfunc);
        if (intervals.size() <= 1)
            return intervals;
        vector<Interval> result;
        Interval tpi(intervals[0].start, intervals[0].end);
        for (int i = 1; i < intervals.size(); ++ i ){
            if (tpi.end < intervals[i].start){
                result.push_back(tpi);
                tpi.start = intervals[i].start;
                tpi.end = intervals[i].end;
            }
            else{
                tpi.end = max(intervals[i].end, tpi.end);
            }
        }
        result.push_back(tpi);
        return result;
    }   

};

int main(){
    return 0;
}