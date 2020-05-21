package library::Controller::Books;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

library::Controller::Books - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched library::Controller::Books in Books.');
}

sub list :Local :Args(0) {
    my ( $self, $c ) = @_;
    my @books = [$c->model('DB::Book')->all];
    $c->stash(books => @books);
    $c->stash(template => 'books/list.tt');
}

sub delete :Local :Args(1) {
    my ( $self, $c, $id ) = @_;
    my $book = $c->model('DB::Book')->find($id);
    $book->delete();
    $c->response->redirect($c->uri_for($self->action_for('list')));

}

sub add :Local :Args(0) {
    my ( $self, $c ) = @_;
    $c->stash(template => 'books/book_form.tt');
}

sub create_book :Local :Args(0){
    my ( $self, $c ) = @_;
    my $book_name = $c->request->params->{name} || 'N/A';
    my $book_author = $c->request->params->{author} || 'N/A';
    my $book = $c->model('DB::Book')->create({
        name=>$book_name,
        author=>$book_author,
    });
    $c->stash(book => $book);
    $c->stash(template => 'books/create_success.tt');
}

=encoding utf8

=head1 AUTHOR

Noura,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
