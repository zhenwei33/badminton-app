class Booking {
  final String bookingId;
  final String uid;
  final String hallId;
  final String hallName;
  final int courtNumber;
  final String bookedDate;
  final String startTime;
  final int bookedHour;
  final double amountPaid;
  final String invoiceId;
  final String paymentDate;

  Booking(
      {this.bookingId,
      this.uid,
      this.hallId,
      this.hallName,
      this.courtNumber,
      this.bookedDate,
      this.startTime,
      this.bookedHour,
      this.amountPaid,
      this.invoiceId,
      this.paymentDate});
}
