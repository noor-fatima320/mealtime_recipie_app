import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../data/meal_data.dart';
import 'cooking_steps_screen.dart';

class CookingModeScreen extends StatefulWidget {
  final Meal meal;

  const CookingModeScreen({super.key, required this.meal});

  @override
  State<CookingModeScreen> createState() => _CookingModeScreenState();
}

class _CookingModeScreenState extends State<CookingModeScreen> {
  int currentStep = 0;

  bool showHandsFree = true;

  // ------------------------------------------------------------
  // TIMER
  // ------------------------------------------------------------

  Timer? _timer;

  bool showTimerPopup = false;

  int selectedTimerMinutes = 0;

  int remainingSeconds = 0;

  bool timerRunning = false;

  // ------------------------------------------------------------
  // CURRENT INSTRUCTION
  // ------------------------------------------------------------

  RecipeInstruction get instruction => widget.meal.instructions[currentStep];

  // ------------------------------------------------------------
  // INIT
  // ------------------------------------------------------------

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() {
          showHandsFree = true;
        });
      }
    });
  }

  // ------------------------------------------------------------
  // DISPOSE TIMER
  // ------------------------------------------------------------

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // ------------------------------------------------------------
  // NEXT STEP
  // ------------------------------------------------------------

  void nextStep() {
    // If current instruction requires timer
    if (instruction.timerMinutes != null && instruction.timerMinutes! > 0) {
      showTimerSelection();
      return;
    }

    moveToNextStep();
  }

  // ------------------------------------------------------------
  // MOVE TO NEXT STEP
  // ------------------------------------------------------------

  void moveToNextStep() {
    if (currentStep < widget.meal.instructions.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      Navigator.pop(context);
    }
  }

  // ------------------------------------------------------------
  // TIMER SELECTION
  // ------------------------------------------------------------

  void showTimerSelection() {
    final defaultMinutes = instruction.timerMinutes ?? 5;

    setState(() {
      selectedTimerMinutes = defaultMinutes;
    });

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Set Timer",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const SizedBox(height: 8),

                    const Text(
                      "Choose how long you want to cook this step.",
                      style: TextStyle(color: Colors.grey, height: 1.4),
                    ),

                    const SizedBox(height: 20),

                    Row(
                      children: [
                        Expanded(
                          child: timerOptionButton(
                            minutes: instruction.timerMinutes ?? 5,
                            selected:
                                selectedTimerMinutes ==
                                (instruction.timerMinutes ?? 5),
                            onTap: () {
                              setModalState(() {
                                selectedTimerMinutes =
                                    instruction.timerMinutes ?? 5;
                              });
                            },
                          ),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: timerOptionButton(
                            minutes: 5,
                            selected: selectedTimerMinutes == 5,
                            onTap: () {
                              setModalState(() {
                                selectedTimerMinutes = 5;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);

                          startTimer(selectedTimerMinutes);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xffF7931A),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          "Next",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ------------------------------------------------------------
  // TIMER OPTION BUTTON
  // ------------------------------------------------------------

  Widget timerOptionButton({
    required int minutes,
    required bool selected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? const Color(0xffE6F6ED) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? const Color(0xff3FA66B) : Colors.grey.shade300,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "$minutes minutes",
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: selected ? const Color(0xff3FA66B) : Colors.black,
              ),
            ),

            const SizedBox(width: 6),

            Icon(
              Icons.play_arrow,
              size: 18,
              color: selected ? const Color(0xff3FA66B) : Colors.black,
            ),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // START TIMER
  // ------------------------------------------------------------

  void startTimer(int minutes) {
    _timer?.cancel();

    setState(() {
      remainingSeconds = minutes * 60;
      timerRunning = true;
      showTimerPopup = true;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }

      if (remainingSeconds > 0) {
        setState(() {
          remainingSeconds--;
        });
      } else {
        timer.cancel();

        setState(() {
          timerRunning = false;
        });
      }
    });
  }

  // ------------------------------------------------------------
  // CANCEL TIMER
  // ------------------------------------------------------------

  void cancelTimer() {
    _timer?.cancel();

    setState(() {
      timerRunning = false;
      showTimerPopup = false;
      remainingSeconds = 0;
    });
  }

  // ------------------------------------------------------------
  // SHOW NEXT STEP FROM TIMER
  // ------------------------------------------------------------

  void showNextStepFromTimer() {
    _timer?.cancel();

    setState(() {
      showTimerPopup = false;
      timerRunning = false;
      remainingSeconds = 0;
    });

    moveToNextStep();
  }

  // ------------------------------------------------------------
  // TIMER +1 MINUTE
  // ------------------------------------------------------------

  void addOneMinute() {
    setState(() {
      remainingSeconds += 60;
    });
  }

  // ------------------------------------------------------------
  // TIMER DISPLAY
  // ------------------------------------------------------------

  String get timerDisplay {
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;

    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  // ------------------------------------------------------------
  // OPEN STEP LIST
  // ------------------------------------------------------------

  void openStepList() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) =>
            CookingStepsScreen(meal: widget.meal, currentStep: currentStep),
      ),
    );

    if (result is int && mounted) {
      setState(() {
        currentStep = result;
      });
    }

    if (result == "leave" && mounted) {
      Navigator.pop(context);
    }
  }

  // ------------------------------------------------------------
  // BUILD
  // ------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFCF8F3),
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                // ------------------------------------------------
                // BACK
                // ------------------------------------------------
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                ),

                // ------------------------------------------------
                // PROGRESS
                // ------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: List.generate(widget.meal.instructions.length, (
                      index,
                    ) {
                      return Expanded(
                        child: Container(
                          height: 6,
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          decoration: BoxDecoration(
                            color: index <= currentStep
                                ? const Color(0xff3FA66B)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                const SizedBox(height: 25),

                // ------------------------------------------------
                // STEP NUMBER
                // ------------------------------------------------
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "${(currentStep + 1).toString().padLeft(2, '0')}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ------------------------------------------------
                // INSTRUCTION
                // ------------------------------------------------
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(25, 0, 25, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          instruction.text,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 1.3,
                          ),
                        ),

                        if (instruction.ingredients.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: instruction.ingredients
                                  .map(
                                    (item) => Padding(
                                      padding: const EdgeInsets.only(bottom: 5),
                                      child: Text(
                                        "• $item",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),

                        // ----------------------------------------
                        // TIMER QUICK BUTTONS
                        // ----------------------------------------
                        if (instruction.timerMinutes != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: [
                                timerQuickButton(
                                  "${instruction.timerMinutes} minutes",
                                  instruction.timerMinutes!,
                                ),

                                const SizedBox(width: 10),

                                timerQuickButton("5 minutes", 5),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                // ------------------------------------------------
                // BOTTOM CONTROLS
                // ------------------------------------------------
                Padding(
                  padding: const EdgeInsets.fromLTRB(18, 10, 18, 15),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 55,
                        height: 52,
                        child: OutlinedButton(
                          onPressed: openStepList,
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.zero,
                            side: BorderSide(color: Colors.grey.shade300),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Icon(
                            Icons.format_list_bulleted,
                            size: 20,
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: nextStep,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xffF7931A),
                            foregroundColor: Colors.black,
                            elevation: 0,
                            minimumSize: const Size(0, 52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: Text(
                            currentStep == widget.meal.instructions.length - 1
                                ? "Finish"
                                : "Next",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            // ----------------------------------------------------
            // HANDS FREE POPUP
            // ----------------------------------------------------
            if (showHandsFree) Positioned.fill(child: buildHandsFreePopup()),

            // ----------------------------------------------------
            // TIMER POPUP
            // ----------------------------------------------------
            if (showTimerPopup) Positioned.fill(child: buildTimerPopup()),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // QUICK TIMER BUTTON
  // ------------------------------------------------------------

  Widget timerQuickButton(String text, int minutes) {
    return GestureDetector(
      onTap: () {
        startTimer(minutes);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: const Color(0xffE6F6ED),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xff3FA66B)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: const Color(0xff3FA66B),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            const Icon(Icons.play_arrow, size: 17, color: Color(0xff3FA66B)),
          ],
        ),
      ),
    );
  }

  // ------------------------------------------------------------
  // HANDS FREE POPUP
  // ------------------------------------------------------------

  Widget buildHandsFreePopup() {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: Colors.black.withOpacity(.18)),
          ),
        ),

        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        showHandsFree = false;
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
                ),

                const Icon(
                  Icons.pan_tool_outlined,
                  size: 38,
                  color: Colors.grey,
                ),

                const SizedBox(height: 12),

                const Text(
                  "Hands-free cooking",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Advance to the next instruction without touching your screen. Hold your hand over the top of your screen until it goes black, then remove.",
                  style: TextStyle(color: Colors.grey, height: 1.4),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showHandsFree = false;
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ------------------------------------------------------------
  // TIMER POPUP
  // ------------------------------------------------------------

  Widget buildTimerPopup() {
    return Stack(
      children: [
        // BLUR
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: Container(color: Colors.black.withOpacity(.18)),
          ),
        ),

        // POPUP
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: const EdgeInsets.all(18),
            padding: const EdgeInsets.fromLTRB(18, 15, 18, 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // CLOSE
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: cancelTimer,
                    icon: const Icon(Icons.close, color: Colors.grey),
                  ),
                ),

                Text(
                  "$selectedTimerMinutes minutes",
                  style: const TextStyle(color: Colors.grey, fontSize: 14),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    Text(
                      timerDisplay,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                      ),
                    ),

                    const Spacer(),

                    OutlinedButton(
                      onPressed: addOneMinute,
                      style: OutlinedButton.styleFrom(
                        foregroundColor: const Color(0xff3FA66B),
                        side: const BorderSide(color: Color(0xff3FA66B)),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        "+1 min",
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                Text(
                  instruction.text,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.grey,
                    height: 1.4,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 20),

                // CANCEL TIMER
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: OutlinedButton(
                    onPressed: cancelTimer,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.grey.shade300),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Cancel Timer",
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // NEXT STEP
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: showNextStepFromTimer,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffF7931A),
                      foregroundColor: Colors.black,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      currentStep < widget.meal.instructions.length - 1
                          ? "Show Step ${currentStep + 2}"
                          : "Finish",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
