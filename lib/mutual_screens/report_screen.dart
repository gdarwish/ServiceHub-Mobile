import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/multy_image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportScreen extends StatefulWidget {
  static const route = '/ReportScreen';
  final ServiceRequest serviceRequest;
  final bool bugReport;

  const ReportScreen({
    Key key,
    this.serviceRequest,
    this.bugReport = false,
  }) : super(key: key);

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  var detailsController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final report = Report(localImages: []);

  @override
  Widget build(BuildContext context) {
    report.serviceRequest = widget.serviceRequest;
    return Scaffold(
      appBar: AppBar(
        title: Text("Report"),
      ),
      body: SafeArea(
        child: BlocConsumer<ReportBloc, ReportState>(
          listener: (context, state) {
            if (state is ReportPostedState) {
              String text;
              if (widget.bugReport)
                text = 'Bug report has been submitted.';
              else
                text = 'Service request report has been submitted.';

              successSnackBar(text, context);
              Navigator.pop(context);
            }
            if (state is ReportFailureState) {
              failureSnackBar(
                state.apiError.message,
                context,
              );
            }
          },
          builder: (context, state) {
            if (state is ReportPostingState) {
              return CustomProgressIndicator();
            }

            return _buildReportScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildReportScreen(BuildContext context) {
    detailsController.text = report.userDetails;
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              // horizontal: 40.0,
              vertical: 20.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //TODO: add report images
                  MultyImageSliser(images: report.localImages),
                  spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CustomTextField(
                      hintText: 'Provide a brief description of the problem',
                      obscureText: false,
                      labelText: 'Details',
                      textFieldController: detailsController,
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Details can\'t be empty.';
                        }
                        if (value.length < 10) {
                          return 'Please enter more descriptive details.';
                        }

                        report.userDetails = value;
                        return null;
                      },
                    ),
                  ),
                  spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: mainBtn('Submit', () {
                      // TODO:: Submit
                      // Local user validate
                      final valid = formKey.currentState.validate();
                      if (!valid) return;

                      BlocProvider.of<ReportBloc>(context).add(
                        PostReport(
                          report,
                          images: report.localImages,
                          isBug: widget.bugReport,
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
