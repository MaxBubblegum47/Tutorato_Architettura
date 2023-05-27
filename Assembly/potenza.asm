#int ricorsione(int a, int n){
#    if(n==1)    return a;
#    else {
#        int x = ricorsione(a, floor(n/2));
#        if (n%2 == 0) return x*x;
#        else return x*x*a;
#    }
#}
#int main(){
#    cout << ricorsione(3,3)<<endl;
#}

.data
.text
	main:
		addi sp, sp, -12
		sw ra, 0(sp)
		sw s0, 4(sp)
		sw s1, 8(sp)
		
		li a0, 3 #primo parametro della funzione ricorsiva
		li a1, 3 #secondo parametro della funzione ricorsiva 
		add s0, a0, zero #Setto s0 come copia del parametro a
		add s1, a1, zero #Setto s1 come copia del parametro n
		
		li a7, 1 #funzione per abilitare la stampa
		jal ra, fun #chiamata alla funzione
		ecall
		jal fine
	fun:
		li t0, 1 #setto il caso base
		beq a1, t0, return #if(n==1)
		
		srli s0, a1, 1 #divido per due
		mv a1, s0 #metto dentro il risultato nel secondo parametro -> a1 = floor(n/2)
		jal zero, fun #chiamo la funzione
		
		mv s1, a0 #risultato della ricorsione -> int x = ricorsione(a, floor(n/2));
		li t2, 2 #mi serve per l'operazione di resto
		rem t3, a1, t2 #t3 = n%2
		mv a1, s1 #metto x al posto di n nei parametri
		
		beq t3, zero, return_ric #-> if (n%2 == 0) return x*x;
		jal return_no_ric #-> else return x*x*a;
		
	return:
		addi a0, a0, 0 #return a0 -> a
		jr ra
	return_ric: #return x*x
		mv s2, a1 
		mul a0, s2, s2
		jr ra
	return_no_ric: #return x*x*a
		mv s2, a1
		mul a1, s2, s2
		mul a0, a0, a1
		jr ra
		
	fine:
		lw s1, 8(sp)
		lw s0, 4(sp)
		lw ra, 0(sp)
		addi sp, sp, 12
		li a7, 93
		li a0, 0
		ecall	
