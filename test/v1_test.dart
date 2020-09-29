import 'package:lemmy_api_client/lemmy_api_client.dart';
import 'package:test/test.dart';

void main() {
  group('lemmy API v1', () {
    final lemmy = LemmyApi('dev.lemmy.ml').v1;

    group('listCategories', () {
      test('correctly fetches', () async {
        await lemmy.listCategories();
      });
    });

    group('search', () {
      test('correctly fetches', () async {
        var res = await lemmy.search(
            type: SearchType.all, q: 'asd', sort: SortType.active);

        expect(res.type, SearchType.all.value);
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.search(
              type: SearchType.all, q: 'asd', sort: SortType.active, page: 0);
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.search(
              type: SearchType.all, q: 'asd', sort: SortType.active, limit: -1);
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.search(
            type: SearchType.all,
            q: 'asd',
            sort: SortType.active,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('addAdmin', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.addAdmin(auth: 'asd', userId: 123, added: true);
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getModlog', () {
      test('correctly fetches', () async {
        var res = await lemmy.getModlog();

        expect(res.banned, isA<List>());
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getModlog(page: 0);
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getModlog(limit: -1);
        }, throwsA(isA<AssertionError>()));
      });
    });

    group('createComment', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createComment(
            content: '123',
            postId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getComments', () {
      test('correctly fetches', () async {
        var res = await lemmy.getComments(
            sort: SortType.active, type: CommentListingType.community);
        expect(res.length, 10);
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getComments(
            sort: SortType.active,
            type: CommentListingType.community,
            page: 0,
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getComments(
            sort: SortType.active,
            type: CommentListingType.community,
            limit: -1,
          );
        }, throwsA(isA<AssertionError>()));
      });
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getComments(
            sort: SortType.active,
            type: CommentListingType.community,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('editComment', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.editComment(
            content: '123',
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('deleteComment', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.deleteComment(
            deleted: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('removeComment', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.removeComment(
            removed: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('markCommentAsRead', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.markCommentAsRead(
            read: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('saveComment', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.saveComment(
            save: true,
            commentId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createCommentLike', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createCommentLike(
            score: VoteType.up,
            commentId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createPost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createPost(
            name: 'asd',
            nsfw: false,
            communityId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getPost', () {
      test('correctly fetches', () async {
        await lemmy.getPost(id: 38936);
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getPost(
            id: 1,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('savePost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.savePost(
            save: true,
            postId: 1,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getPosts', () {
      test('correctly fetches', () async {
        var res = await lemmy.getPosts(
            type: PostListingType.all, sort: SortType.active);
        expect(res.length, 10);
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getPosts(
              type: PostListingType.all, sort: SortType.active, page: 0);
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getPosts(
              type: PostListingType.all, sort: SortType.active, limit: -1);
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getPosts(
              type: PostListingType.all, sort: SortType.active, auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createPostLike', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createPostLike(
            postId: 1,
            score: VoteType.up,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('editPost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.editPost(
            name: 'asd',
            nsfw: false,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('deletePost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.deletePost(
            deleted: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('removePost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.removePost(
            removed: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('lockPost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.lockPost(
            locked: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('stickyPost', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.stickyPost(
            stickied: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('login', () {
      test('handles invalid credentials', () async {
        expect(() async {
          await lemmy.login(
            usernameOrEmail: '123',
            password: '123',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    // group('register', () {
    //   test('handles already existing accounts', () async {
    //     expect(() async {
    //       await lemmy.register(
    //         username: 'krawieck',
    //         password: '123',
    //         passwordVerify: '123',
    //         admin: false,
    //       );
    //     }, throwsA(isA<UsernameTakenException>()));
    //   });

    //   test('handles too simple passwords', () async {
    //     expect(() async {
    //       await lemmy.register(
    //         username: 'krawieck',
    //         password: '123',
    //         passwordVerify: '123',
    //         admin: false,
    //       );
    //     }, throwsA(isA<TooSimplePasswordException>()));
    //   });

    //   test('when a captcha paramenter is present, all should be passed',
    //       () async {
    //     expect(() async {
    //       await lemmy.register(
    //         username: 'krawieck',
    //         password: '123',
    //         passwordVerify: '123',
    //         admin: false,
    //         captchaUuid: 'asd',
    //       );
    //     }, throwsA(isA<AssertionError>()));

    //     expect(() async {
    //       await lemmy.register(
    //         username: 'krawieck',
    //         password: '123',
    //         passwordVerify: '123',
    //         admin: false,
    //         captchaAnswer: 'asd',
    //       );
    //     }, throwsA(isA<AssertionError>()));
    //   });
    // });

    // group('getCaptcha', () {
    //   test('correctly fetches', () async {
    //     await lemmy.getCaptcha();
    //   });
    // });

    group('getUserDetails', () {
      test('correctly fetches', () async {
        await lemmy.getUserDetails(
            sort: SortType.active, username: 'krawieck', savedOnly: false);
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getUserDetails(
              sort: SortType.active, savedOnly: false, page: 0);
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getUserDetails(
              sort: SortType.active, savedOnly: false, limit: -1);
        }, throwsA(isA<AssertionError>()));
      });

      test('forbids both username and userId being passed at once', () async {
        expect(() async {
          await lemmy.getUserDetails(
            sort: SortType.active,
            username: 'asd',
            savedOnly: false,
            userId: 123,
          );
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getUserDetails(
            sort: SortType.active,
            savedOnly: false,
            username: 'asd',
            auth: '123',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('saveUserSettings', () {
      test('when any password is passed, the rest should be present', () async {
        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            newPassword: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            newPasswordVerify: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            oldPassword: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            newPassword: 'asd',
            newPasswordVerify: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            newPassword: 'asd',
            oldPassword: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            newPasswordVerify: 'asd',
            oldPassword: 'asd',
            auth: '123',
          );
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.saveUserSettings(
            showNsfw: true,
            theme: 'asd',
            defaultSortType: SortType.active,
            defaultListingType: PostListingType.all,
            sendNotificationsToEmail: false,
            showAvatar: false,
            lang: 'en',
            auth: '123',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('banUser', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.banUser(userId: 123, ban: true, auth: '123');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getReplies', () {
      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getReplies(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
            page: 0,
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getReplies(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
            limit: -1,
          );
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getReplies(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getCommunity', () {
      test('correctly fetches', () async {
        await lemmy.getCommunity(name: 'javascript');
      });

      test('forbids both name and id being passed at once', () async {
        expect(() async {
          await lemmy.getCommunity(name: 'asd', id: 12);
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getCommunity(name: 'asd', auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createCommunity(
            name: 'asd',
            title: 'asd',
            categoryId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('editCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.editCommunity(
            editId: 123,
            title: 'asd',
            categoryId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('banFromCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.banFromCommunity(
            communityId: 123,
            userId: 123,
            ban: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('addModToCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.addModToCommunity(
            communityId: 123,
            userId: 123,
            added: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('deleteCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.deleteCommunity(
            editId: 123,
            deleted: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('removeCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.removeCommunity(
            editId: 123,
            removed: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('transferCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.transferCommunity(
            communityId: 123,
            userId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('listCommunities', () {
      test('correctly fetches', () async {
        await lemmy.listCommunities(sort: SortType.active);
      });

      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.listCommunities(sort: SortType.active, page: 0);
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.listCommunities(sort: SortType.active, limit: -1);
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.listCommunities(sort: SortType.active, auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('followCommunity', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.followCommunity(
            communityId: 123,
            follow: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getFollowedCommunities', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getFollowedCommunities(auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getSite', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getSite(auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createSite', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createSite(name: 'asd', auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('editSite', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.editSite(name: 'asd', auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('transferSite', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.transferSite(userId: 123, auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getSiteConfig', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getSiteConfig(auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('saveSiteConfig', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.saveSiteConfig(configHjson: 'asd', auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getUserMentions', () {
      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getUserMentions(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
            page: 0,
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getUserMentions(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
            limit: -1,
          );
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getUserMentions(
            sort: SortType.active,
            unreadOnly: false,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('markUserMentionAsRead', () {
      test('handles invalid credentials', () async {
        expect(() async {
          await lemmy.markUserMentionAsRead(
            userMentionId: 123,
            read: true,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('getPrivateMessages', () {
      test('forbids illegal numbers', () async {
        expect(() async {
          await lemmy.getPrivateMessages(
            unreadOnly: false,
            auth: 'asd',
            page: 0,
          );
        }, throwsA(isA<AssertionError>()));

        expect(() async {
          await lemmy.getPrivateMessages(
            unreadOnly: false,
            auth: 'asd',
            limit: -1,
          );
        }, throwsA(isA<AssertionError>()));
      });

      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.getPrivateMessages(
            unreadOnly: false,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('createPrivateMessage', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.createPrivateMessage(
            content: 'asd',
            recipientId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('editPrivateMessage', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.editPrivateMessage(
            content: 'asd',
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('deletePrivateMessage', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.deletePrivateMessage(
            deleted: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('markPrivateMessageAsRead', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.markPrivateMessageAsRead(
            read: true,
            editId: 123,
            auth: 'asd',
          );
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('markAllAsRead', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.markAllAsRead(auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });

    group('deleteAccount', () {
      test('handles invalid tokens', () async {
        expect(() async {
          await lemmy.deleteAccount(password: 'asd', auth: 'asd');
        }, throwsA(isA<InvalidAuthException>()));
      });
    });
  });
}
