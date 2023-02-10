# Trivial Flag Transfer Protocol

## Skills & Concepts Involved
- Network packet monitoring
- parsing packet captures using Wireshark (tshark is its command-line version)
- steganography using steghide

## Common portion of path
This is the part of the solution that is common to any operating system.

- Download the file. We see it's called `tftp.pcapng`
- What is a .pcapng file? It's a packet capture (new generation) file format for network packets previously captured & saved in the file. Wireshark is the most commonly used free utility for reading it, so we'll use that.
- Open it with Wireshark (GUI)
- File > Export Objects > TFTP > Save All (In some folder you like)
- Go to that folder
- Observe the files:

```
instructions.txt
plan
program.deb
picture1.bmp
picture2.bmp
picture3.bmp
```

- If you look closely at the Wireshark information, you'll see that instructions.txt was sent from 10.10.10.11 to 10.10.10.12. We'll refer to them as 11 and 12 henceforth.
- So what does 11 say to 12? The string looks like this: `GSGCQBRFAGRAPELCGBHEGENSSVPFBJRZHFGQVFTHVFRBHESYNTGENAFSRE.SVTHERBHGNJNLGBUVQRGURSYNTNAQVJVYYPURPXONPXSBEGURCYNA`
- This looks like a ciphered text. So we'll go to https://www.dcode.fr/shift-cipher to try to decipher it.
- Paste the string into the website, then click "Decrypt." You'll find to the left that the top match is ROT13 (the simplest Caesar cipher due to its ability to reverse itself, since 13 + 13 = 26.). It says: `TFTPDOESNTENCRYPTOURTRAFFICSOWEMUSTDISGUISEOURFLAGTRANSFER.FIGUREOUTAWAYTOHIDETHEFLAGANDIWILLCHECKBACKFORTHEPLAN`

- Okay, 11 is telling 12 to figure out a way to hide the flag and send back a plan for doing so.

- Next, we see in Wireshark that 12 sends the file 'plan' to 11.

- Let's see what it says: `VHFRQGURCEBTENZNAQUVQVGJVGU-QHRQVYVTRAPR.PURPXBHGGURCUBGBF`

- Back in the cipher. We get: `IUSEDTHEPROGRAMANDHIDITWITH-DUEDILIGENCE.CHECKOUTTHEPHOTOS`

- Okay. It says that 12 used the program (probably program.deb) to hide the flag in the pictures.

- Let's run the program on the pictures.

## Webshell branch

```bash
# Make sure you have dpkg on your Linux install
# Let's run the program hidden in program.deb
# We don't have root access, so we'll need to run a trick using dpkg (credit to Freeman)
dpkg -x program.deb program

# See the program output folder: program/
cd program
cd usr
cd bin

# So we see our executable is called steghide. Let's run it:
steghide

# This gives us some help with how to use it

# After fiddling around, we realize we need to use a password for the extraction of some hidden phrase from a picture. We try a bunch of pictures, using the password hint in the plan called 'DUEDILIGENCE' 
steghide extract -sf ../../../picture3.bmp -p DUEDILIGENCE

# This generates the output file flag.txt

# Open up the flag.txt
cat ../../../flag.txt

# This gives us our picoCTF flag!
```
