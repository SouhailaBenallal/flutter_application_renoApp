import 'package:flutter/material.dart';
import 'constants.dart';

class BigButton extends StatelessWidget {
  final dynamic function;
  final String title;
  final Color buttonColor;

  const BigButton({
    required this.function,
    required this.title,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(7)),
      ),
      child: RawMaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(7)),
        ),
        fillColor: buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        highlightElevation: 0,
        elevation: 0,
        onPressed: function,
        child: Text(
          title,
          style: kTextButton,
        ),
      ),
    );
  }
}

class DecisionButton extends StatelessWidget {
  final dynamic function;
  final String title;
  final Color buttonColor;

  const DecisionButton({
    required this.function,
    required this.title,
    required this.buttonColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(3.5)),
      ),
      child: RawMaterialButton(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(3.5)),
        ),
        fillColor: buttonColor,
        padding: const EdgeInsets.symmetric(vertical: 7.5),
        highlightElevation: 0,
        elevation: 2.5,
        onPressed: function,
        child: Text(
          title,
          style: kTextButton2,
        ),
      ),
    );
  }
}

class JobsListListTile extends StatelessWidget {
  final String typeOfWork;
  final String address;
  final String date;
  final String duration;

  const JobsListListTile({
    required this.typeOfWork,
    required this.address,
    required this.date,
    required this.duration,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      dense: true,
      //contentPadding: EdgeInsets.zero,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(typeOfWork, style: kHeadline4)),
          Text(duration, style: kHeadline4),
        ],
      ),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(address, style: kHeadline4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: Text(date, style: kHeadline4)),
              Row(
                children: [
                  SizedBox(
                    width: 75,
                    height: 30,
                    child: DecisionButton(
                        function: () {},
                        title: "Accept",
                        buttonColor: kColorYellow),
                  ),
                  const SizedBox(width: kBigSpacing),
                  SizedBox(
                    width: 75,
                    height: 30,
                    child: DecisionButton(
                        function: () {},
                        title: "Decline",
                        buttonColor: kColorGrey),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class AcceptedJobsListTile extends StatelessWidget {
  final bool isHandymanSide;
  final String status;
  final String typeOfWork;
  final String address;
  final String date;
  final String duration;
  final Color statusColor;
  const AcceptedJobsListTile({
    required this.isHandymanSide,
    this.status = "",
    required this.typeOfWork,
    required this.address,
    required this.date,
    required this.duration,
    this.statusColor = Colors.white,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(typeOfWork, style: kHeadline4)),
              Text(duration, style: kHeadline4),
            ],
          ),
          Text(address, style: kHeadline4),
          Text(date, style: kHeadline4)
        ],
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: kBigSpacing),
        child: isHandymanSide
            ? Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: DecisionButton(
                          function: () {},
                          title: "Begin",
                          buttonColor: kColorGrey),
                    ),
                  ),
                  const SizedBox(width: kBigSpacing),
                  Expanded(
                    child: SizedBox(
                      height: 45,
                      child: DecisionButton(
                          function: () {},
                          title: "Finish",
                          buttonColor: kColorYellow),
                    ),
                  ),
                ],
              )
            : SizedBox(
                height: 45,
                child: DecisionButton(
                    function: () {}, title: status, buttonColor: statusColor),
              ),
      ),
    );
  }
}

class HistoryJobsListTile extends StatelessWidget {
  final String typeOfWork;
  final String customerName;
  final String date;
  final String price;

  const HistoryJobsListTile({
    required this.typeOfWork,
    required this.customerName,
    required this.date,
    required this.price,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      contentPadding: EdgeInsets.zero,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(typeOfWork, style: kHeadline4)),
              Text(price, style: kHeadline4.copyWith(color: Colors.orange)),
            ],
          ),
          Text(customerName, style: kHeadline4),
          Text(date, style: kHeadline4)
        ],
      ),
    );
  }
}

class AppFormFieldBottomLined extends StatelessWidget {
  final String textValidation;
  final String labelText;
  final bool obscureText;
  const AppFormFieldBottomLined({
    required this.textValidation,
    required this.labelText,
    required this.obscureText,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(border: Border(bottom: BorderSide(color: kColorGrey))),
      child: TextFormField(
        validator: (val) {
          return val!.isNotEmpty ? null : textValidation;
        },
        style: TextStyle(color: kColorBlack),
        obscureText: obscureText,
        decoration: InputDecoration(
          border: InputBorder.none,
          errorMaxLines: 4,
          labelText: labelText,
          labelStyle: kHeadline5,
        ),
      ),
    );
  }
}

class ServicesCard extends StatelessWidget {
  final String serviceName;
  final String imagePath;
  const ServicesCard({
    required this.serviceName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => ServiceDialog(
                  imagePath: imagePath, serviceName: serviceName));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 5.0),
          decoration: BoxDecoration(
            color: kColorWhite,
            border: Border.all(color: kColorBlack),
            borderRadius: const BorderRadius.all(
              Radius.circular(7),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                serviceName,
                style: kHeadline5.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: kBigSpacing),
              Image.asset(imagePath)
            ],
          ),
        ),
      ),
    );
  }
}

class AppFormFieldWithFullBackground extends StatelessWidget {
  final String textValidation;
  final String hintText;
  final Color backgroundColor;
  final Color borderColor;
  final dynamic icon;

  const AppFormFieldWithFullBackground({
    required this.textValidation,
    required this.hintText,
    required this.backgroundColor,
    required this.borderColor,
    required this.icon,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(7)),
        border: Border.all(
          color: borderColor,
        ),
      ),
      child: TextFormField(
        validator: (val) {
          return val!.isNotEmpty ? null : textValidation;
        },
        style: TextStyle(color: kColorBlack),
        decoration: InputDecoration(
          border: InputBorder.none,
          errorMaxLines: 4,
          hintText: hintText,
          hintStyle: kHeadline5.copyWith(color: Colors.black.withOpacity(0.50)),
          icon: Padding(
            padding: const EdgeInsets.only(left: 15.0),
            child: GestureDetector(
              onTap: () {},
              child: Icon(
                icon,
                color: Colors.grey.shade400,
                size: 20.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MandatoryStepContainer extends StatelessWidget {
  final dynamic title;
  final dynamic function;
  final dynamic trailing;
  final double spacing;
  const MandatoryStepContainer({
    required this.title,
    required this.function,
    required this.trailing,
    this.spacing = kBigSpacing * 2,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: spacing),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: kColorBlack),
        ),
      ),
      child: ListTile(
        onTap: function,
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: title,
        trailing: trailing,
      ),
    );
  }
}

class MandatoryStepContainer2 extends StatelessWidget {
  final dynamic title;
  const MandatoryStepContainer2({
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        dense: true,
        contentPadding: EdgeInsets.zero,
        title: title,
      ),
    );
  }
}

class ServiceDialog extends StatelessWidget {
  final String imagePath;
  final String serviceName;

  const ServiceDialog({
    required this.imagePath,
    required this.serviceName,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                imagePath,
                scale: 6,
              ),
            ),
            Text(serviceName, style: kHeadline2),
            const SizedBox(height: kBigSpacing * 2),
            Container(
              decoration: BoxDecoration(
                color: kColorLightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
              ),
              child: TextFormField(
                validator: (val) {
                  return val!.isNotEmpty ? null : "";
                },
                maxLines: 5,
                minLines: 2,
                style: TextStyle(color: kColorBlack),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  errorMaxLines: 4,
                  hintText: "Describe",
                  hintStyle: kHeadline5.copyWith(
                      color: Colors.black.withOpacity(0.50)),
                ),
              ),
            ),
            const SizedBox(height: kBigSpacing),
            Container(
              decoration: BoxDecoration(
                color: kColorLightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
              ),
              child: TextFormField(
                validator: (val) {
                  return val!.isNotEmpty ? null : "";
                },
                maxLines: 5,
                minLines: 2,
                style: TextStyle(color: kColorBlack),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  errorMaxLines: 4,
                  hintText: "Adress",
                  hintStyle: kHeadline5.copyWith(
                      color: Colors.black.withOpacity(0.50)),
                ),
              ),
            ),
            const SizedBox(height: kBigSpacing),
            Container(
              decoration: BoxDecoration(
                color: kColorLightGrey,
                borderRadius: const BorderRadius.all(Radius.circular(7)),
              ),
              child: TextFormField(
                validator: (val) {
                  return val!.isNotEmpty ? null : "";
                },
                minLines: 1,
                style: TextStyle(color: kColorBlack),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  border: InputBorder.none,
                  errorMaxLines: 4,
                  hintText: "Choose date",
                  hintStyle: kHeadline5.copyWith(
                      color: Colors.black.withOpacity(0.50)),
                ),
              ),
            ),
            const SizedBox(height: kBigSpacing * 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: kColorBlack,
                    radius: 10,
                    child: CircleAvatar(
                      backgroundColor: kAppBackgroundColor,
                      radius: 9,
                      child: Icon(
                        Icons.remove,
                        size: 10,
                        color: kColorBlack,
                      ),
                    ),
                  ),
                ),
                Text(
                  " 1h ",
                  style: kHeadline4,
                ),
                IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: kColorBlack,
                    radius: 10,
                    child: CircleAvatar(
                      backgroundColor: kAppBackgroundColor,
                      radius: 9,
                      child: Icon(
                        Icons.add,
                        size: 10,
                        color: kColorBlack,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: kBigSpacing * 2),
            BigButton(
                function: () {}, title: "Send", buttonColor: kColorYellow),
          ],
        ),
      ),
    ));
  }
}

class ServiceStatusNotification extends StatelessWidget {
  final String title;
  final bool isDone;

  const ServiceStatusNotification({
    required this.title,
    required this.isDone,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: kHeadline2),
            const SizedBox(height: kBigSpacing * 2),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                color: kColorYellow,
                borderRadius: BorderRadius.circular(7),
              ),
              child: Center(
                child: Text(
                  "90 €",
                  style: kHeadline1.copyWith(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: kBigSpacing),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: isDone
                  ? BigButton(
                      function: null, title: "Done!", buttonColor: kColorBlack)
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 75,
                          height: 45,
                          child: DecisionButton(
                              function: () {},
                              title: "Accepted!",
                              buttonColor: Colors.green),
                        ),
                        const SizedBox(width: kBigSpacing),
                        SizedBox(
                          width: 75,
                          height: 45,
                          child: DecisionButton(
                              function: () {},
                              title: "Decline",
                              buttonColor: Colors.red),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    ));
  }
}
