/*
4.
Let’s say we want to print numbers from 0 - 4 we can use for loop to print all of them! But we want them
to print with a delay of `n` seconds where `n` is the current iteration for example in 1st iteration the 
delay is 0 seconds and in 2nd it’s 1 seconds and in 3rd it’s 2 seconds and so on..
The following code doesn’t seem to work as expected, please find the bug and help fix it with a brief explanation
for (var i = 0; i < 5; i++) {
  setTimeout(function () {
    console.log(i);
  }, i * 1000);
}
*/

// Ans..... only need to change the i variable type var to let ..

for (let i = 0; i < 5; i++) {
    setTimeout(function () {
      console.log(i);
    }, i * 1000);
  }



