import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixieapp/const/colors.dart';
import 'package:pixieapp/widgets/widgets_index.dart';

class AddCharactorStory extends StatefulWidget {
  const AddCharactorStory({super.key});

  @override
  State<AddCharactorStory> createState() => _AddCharactorStoryState();
}

class _AddCharactorStoryState extends State<AddCharactorStory> {
  final TextEditingController _characterController = TextEditingController();
  bool _isLoading = false; // Track loading state

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: MediaQuery.of(context).size.height * .7,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: AppColors.bottomSheetBackground,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 25, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add a character',
              style: theme.textTheme.displayMedium?.copyWith(
                color: AppColors.textColorblue,
                fontSize: 34,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 25),

            // Character TextField
            TextField(
              controller: _characterController,
              autofocus: true,
              decoration: const InputDecoration(
                hintText: "Character name",
                hintStyle: TextStyle(color: Color.fromARGB(255, 199, 199, 199)),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textColorblue,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.textColorblue,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              style: const TextStyle(color: Colors.black),
            ),

            const SizedBox(height: 10),

            // Submit Button
            SizedBox(
              width: MediaQuery.of(context).size.width * .9,
              child: ElevatedButton(
                onPressed: _isLoading
                    ? null // Disable button when loading
                    : () async {
                        if (_characterController.text.isNotEmpty) {
                          String newCharacter = _characterController.text;

                          // Show loading indicator
                          setState(() {
                            _isLoading = true;
                          });

                          // Call function to add character to Firestore
                          await _addCharacterToFirestore(newCharacter);
                        }
                      },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  foregroundColor: AppColors.buttonblue,
                  backgroundColor: AppColors.buttonblue,
                ),
                child: _isLoading
                    ? const SizedBox(height: 50, child: LoadingWidget())
                    : Text(
                        "Add",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textColorWhite,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to add character to Firestore
  Future<void> _addCharacterToFirestore(String character) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        DocumentReference userDoc =
            FirebaseFirestore.instance.collection('users').doc(user.uid);

        await FirebaseFirestore.instance.runTransaction((transaction) async {
          DocumentSnapshot snapshot = await transaction.get(userDoc);

          if (!snapshot.exists) {
            throw Exception("User does not exist!");
          }

          // Get the existing story characters or create a new list if the field doesn't exist
          List<dynamic> storyCharacters =
              (snapshot.data() as Map<String, dynamic>?)?['storycharactors'] ??
                  [];

          // Add the new character if it's not already in the list
          if (!storyCharacters.contains(character)) {
            storyCharacters.add(character);
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            //   content: Text('Character already exists!'),
            // ));
            return;
          }

          // Update Firestore with the new list, creating the 'storycharactors' field if it doesn't exist
          transaction.set(userDoc, {'storycharactors': storyCharacters},
              SetOptions(merge: true));
        });

        // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //   content: Text('Character added successfully!'),
        // ));

        // Go back once data is added
        Navigator.of(context).pop();
      }
    } catch (e) {
      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      //   content: Text('Failed to add character: ${e.toString()}'),
      // ));
    } finally {
      // Hide loading indicator
      setState(() {
        _isLoading = false;
      });
    }
  }
}
