double findMedianSortedArrays(int A[], int m, int B[], int n) {  
	
	if ((m + n) % 2 != 0) // odd
		return (double) findKth(A, B, (m + n) / 2, 0, m - 1, 0, n - 1);
	else { // even
		return (findKth(A, B, (m + n) / 2, 0, m - 1, 0, n - 1) + findKth(A, B, (m + n) / 2 - 1, 0, m - 1, 0, n - 1)) * 0.5;
	}
}
 
double findKth(int A[], int B[], int k, int aStart, int aEnd, int bStart, int bEnd) {
 
	int aLen = aEnd - aStart + 1;
	int bLen = bEnd - bStart + 1;
 
	// Handle special cases
	if (aLen == 0)
		return B[bStart + k];
	if (bLen == 0)
		return A[aStart + k];
	if (k == 0)
		return A[aStart] < B[bStart] ? A[aStart] : B[bStart];
 
	int aMid = aLen * k / (aLen + bLen); // a's middle count
	int bMid = k - aMid - 1; // b's middle count
	assert(aMid + bMid + 1 = k);
 
	// make aMid and bMid to be array index
	aMid = aMid + aStart;
	bMid = bMid + bStart;
 
	if (A[aMid] > B[bMid]) { 
		k = k - (bMid - bStart + 1);
		aEnd = aMid; // eliminate upper portion of A
		bStart = bMid + 1; //eliminate lower portion of B
	} else { // 
		k = k - (aMid - aStart + 1);
		bEnd = bMid; // eliminate upper portion of B
		aStart = aMid + 1;  // eliminate lower portion of A
	}
 
	return findKth(A, B, k, aStart, aEnd, bStart, bEnd);
}




int findKthSmallest(int A[], int m, int B[], int n, int k) {
  assert(m >= 0); assert(n >= 0); assert(k > 0); assert(k <= m+n);
  
  int i = (int)((double)m / (m+n) * (k-1));
  int j = (k-1) - i;
 
  assert(i >= 0); assert(j >= 0); assert(i <= m); assert(j <= n);
  // invariant: i + j = k-1
  // Note: A[-1] = -INF and A[m] = +INF to maintain invariant
  int Ai_1 = ((i == 0) ? INT_MIN : A[i-1]);
  int Bj_1 = ((j == 0) ? INT_MIN : B[j-1]);
  int Ai   = ((i == m) ? INT_MAX : A[i]);
  int Bj   = ((j == n) ? INT_MAX : B[j]);
 
  if (Bj_1 < Ai && Ai < Bj)
    return Ai;
  else if (Ai_1 < Bj && Bj < Ai)
    return Bj;
 
  assert((Ai > Bj && Ai_1 > Bj) || 
         (Ai < Bj && Ai < Bj_1));
 
  // if none of the cases above, then it is either:
  if (Ai < Bj)
    // exclude Ai and below portion
    // exclude Bj and above portion
    return findKthSmallest(A+i+1, m-i-1, B, j, k-i-1);
  else /* Bj < Ai */
    // exclude Ai and above portion
    // exclude Bj and below portion
    return findKthSmallest(A, i, B+j+1, n-j-1, k-j-1);
}